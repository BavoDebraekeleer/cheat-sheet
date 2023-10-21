# Entity Framework Core

## Courses and Documentation

- [Pluralsight: ASP.NET Core 6 Web API Fundamentals by Kevin Dockx](https://app.pluralsight.com/library/courses/asp-dot-net-core-6-web-api-fundamentals/table-of-contents)
- [EF Core Raw SQL Query](https://www.learnentityframeworkcore.com/raw-sql)


---

## Introduction

Entity Framework is an ORM, or Object-Relational Mapper, which is a technique that lets you query and manipulate data from a database using an object-oriented paradigm.
Mapping the Database Tables to Object Models.

---

## Entity Classes

A sort of Model on how the data will be stored in a Table.
Similar to an SQL Table Design.

Entity Class Example:
```c#
using DotNetApiApp.Domain.Models;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DotNetApiApp.Infrastructure.Entities;

public class User
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public long Id { get; set; }

    [ForeignKey("CompanyId")]
    public Company? Company { get; set; }
    public long CompanyId { get; set; }

    [Required]
    [MaxLength(50)]
    public string Name { get; set; }

    public List<TimeRegistration> TimeRegistrations { get; set; } = new List<TimeRegistration>();

    public User(string name)
    {
        Name = name;
    }
}
```

Of Object Model:
```c#
namespace DotNetApiApp.Domain.Models;

public class User
{
    public long Id { get; set; }
    public long CompanyId { get; set; }
    public string Name { get; set; } = string.Empty;
    public List<TimeRegistration> TimeRegistrations { get; set; } = new List<TimeRegistration>();
}
```


---

## Entity Type Configurations

Another way is to generate Entities from the Models.

Entity Type Configuration of the same Model as above:
```c#
using DotNetApiApp.Domain.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Emit;

namespace DotNetApiApp.Infrastructure.EntityTypeConfigurations;

public class CompanyConfiguration : IEntityTypeConfiguration<Company>
{
    public void Configure(EntityTypeBuilder<Company> modelBuilder)
    {
        modelBuilder.ToTable("Company")
                .HasMany(e => e.Users)
                .WithOne();
    }
}
```

---

## [DbContext](https://learn.microsoft.com/en-us/ef/core/dbcontext-configuration/)

Now, depending on whether you are using Entity Classes or Entity Type Configurations, the DbContext will be slightly different.

The DbContext has to be registered as a Service in the DI Container:
```c#
// DbContexts
var configBuilder = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile(
	            "appsettings.json", 
	            optional: true, 
	            reloadOnChange: true);

IConfiguration config = configBuilder.Build();

builder.Services.AddDbContext<NameDbContext>(options =>
    options.UseSqlServer(config.GetConnectionString("DefaultConnection")));
```

To do this securely we have to only set the connection string in the `appsettings.Development.json`, and for production, use an Environment Variable.
This way it doesn't end up in git in a plain text file.
A key vault, like Azure Key Vault, is an even better option.

This is the order where the builder looks for the connection string:
![[Pasted image 20231019093054.png]]

In the Immediate Window you can check variables:
![[Pasted image 20231019093257.png]]


### Entity Classes

When using Entity Classes, we use these to tell the DbContext which DbSets to build:
```c#
using Microsoft.EntityFrameworkCore;
using DotNetApiApp.Infrastructure.Entities;

namespace DotNetApiApp.Infrastructure.DbContexts;

public class EntitiesDbContext : DbContext
{
    // Infrastructure Entities
    public DbSet<Company> Company { get; set; }
    public DbSet<User> User { get; set; }
    public DbSet<TimeRegistration> TimeRegistration { get; set; }
}
```

### Entity Type Configurations

When using Entity Type Configurations, we use these and the Object Models to tell a ModelBuilder which DbSets to build:
```c#
using Microsoft.EntityFrameworkCore;
using System.Reflection;
using System;
using DotNetApiApp.Domain.Models;

namespace DotNetApiApp.Infrastructure.DbContexts;

public class ConfigurationsDbContext : DbContext
{
	// Domain Models
    public DbSet<Company> Company { get; set; }
    public DbSet<User> User { get; set; }
    public DbSet<TimeRegistration> TimeRegistration { get; set; }

	// Constructor
    public ConfigurationsDbContext(
	    DbContextOptions<ConfigurationsDbContext> options) : base(options) { }
    
    protected override void OnConfiguring(
	    DbContextOptionsBuilder optionsBuilder) { }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
	    modelBuilder.ApplyConfigurationsFromAssembly(
		    Assembly.GetExecutingAssembly());
    }
}

```

---

## Migrations

Using `Microsoft.entityFrameworkCore.Tools`.

### Make Migration

Available commands through the package manager console:
```cli
Add-Migration NameInitialCreate -Context NameDbContext -OutputDir Migrations
```

Make sure the Default project at the top is set to the project that holds the entities and optional DbContext. This is also where the Migrations will be put in.
*See [Microsoft: Migrations with miltiple providers](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/providers?tabs=vs).*

![[Pasted image 20231019071905.png]]

### Publish/Update Database

To publish the migration, use the following migration:
```cli
update-database -Context NameDbContext
// eg: update-database -Context EntitiesDbContext
```

If a login error occurs:
![[Pasted image 20231019083308.png]]
`A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - De certificaatketen is verleend door een niet-vertrouwde instantie.)`

Make sure the following is in your connection string:
```c#
"ConnectionStrings": {
  "DefaultConnection": "Server=.\\sqlexpress;Database=Name;" +
	  "Trusted_Connection=True;" +
	  "TrustServerCertificate=True;"
}
```

### SQLite and SQL Server Compact Toolbox

Install in: Extensions > Manage Extensions
![[Pasted image 20231019072840.png]]

Open in: Tools

### Seeding Data

Seeding data for testing can be done in the DbContext:
```c#
// Seeding
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    modelBuilder.Entity<Company>()
        .HasData(
            new Company("Vermeulen Transport BVBA")
            {
                Id = 1,
                // Name in constructor
            }
        );

    modelBuilder.Entity<User>()
        .HasData(
            new User("Jos Vermeulen")
            {
                Id        = 1,
                CompanyId = 1,
                // Name in constructor
            }
        );

    modelBuilder.Entity<TimeRegistration>()
        .HasData(
            new TimeRegistration()
            {
                Id          = 1,
                UserId      = 1,
                Description = "Kantoor",
                Start       = new DateTime(2023, 10, 17,  8, 0, 0),
                Stop        = new DateTime(2023, 10, 17, 18, 0, 0),
            }
        );

    base.OnModelCreating(modelBuilder);
}
```

Add the new Migration:
```cli
add-migration DataSeed -Context NameDbContext -OutputDir Migrations
```

And Update the Database with the new Migration:
```cli
update-database -Context NameDbContext
```

---

## Repository Pattern

The Repository Pattern is an abstraction that reduces complexity, and aims to make the code, safe for the repository implementation, persistence ignorant.

![[Pasted image 20231019094429.png]]

Persistence Ignorant means the ability to choose which technology to use for which method in the repository.

### AutoMapper

Install `AutoMapper` and `AutoMapper.Extensions.Microsoft.DependencyInjection` via NuGet.

Maps property names from the source (Entity) to the same property names on the destination (DTO). By default, it ignores NullReferenceExceptions from source to destination.

To use AutoMapper, a Profile is needed.
In Infrastructure, create folder Profiles, and create a Profile for each Entity.

Use `CreateMap` in the constructor, to map the Entity to the DTO:
```c#
using AutoMapper;

namespace DotNetApiApp.Infrastructure.Profiles;

public class TimeRegistrationProfile : Profile
{
    public TimeRegistrationProfile()
    {
        CreateMap<
	        Entities.TimeRegistration, 
	        TimeRegistrationDTO>();
    }
}
```

Add the IMapper to the Controller constructor:
```c#
public TimeRegistrationController(
    ITimeRegistrationRepository timeRegistrationRepository,
    IMapper mapper)
{
    _timeRegistrationRepository = timeRegistrationRepository ??
        throw new ArgumentNullException(nameof(timeRegistrationRepository));
    _mapper = mapper ??
        throw new ArgumentNullException(nameof(mapper));
}
```

Add the Service to the DI Container:
```c#
builder.Services.AddScoped<
	ITimeRegistrationRepository, 
	TimeRegistrationRepository>();

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
```

Usage in the Controller:
```c#
return Ok(_mapper.Map<ReturnType>(entity)); // Map Entity to DTO defined in Profile
//return Ok(_mapper.Map<List<TimeRegistration>>(entity)); 
```
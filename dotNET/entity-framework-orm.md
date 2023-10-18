# Entity Framework Core

## Courses and Documentation

- [Pluralsight: ASP.NET Core 6 Web API Fundamentals by Kevin Dockx](https://app.pluralsight.com/library/courses/asp-dot-net-core-6-web-api-fundamentals/table-of-contents)

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
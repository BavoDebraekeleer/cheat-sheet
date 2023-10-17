# Dapper

## Courses

- [Pluralsight: Dapper: Getting Started by Steve Michelotti](https://app.pluralsight.com/library/courses/getting-started-dapper/table-of-contents)
- [GitHub of Dapper with basic documentation.](https://github.com/DapperLib/Dapper)

---

## Introduction

Dapper is a .NET Micro-ORM.

An ORM is an Object Relational Mapper, and is responsible for the mapping between the database and the .NET objects.

A Micro-ORM only handles the mapping, and doing that really fast. Without the extra functionalities of a standard ORM, like Entity Framework, that also handles the SQL, among other things.

![[Pasted image 20231016222911.png]]

![[Pasted image 20231016223031.png]]

```c#
// Entity Framework: 
var contacts = context.Contacts.Where(c => c.Id == id); 
var contacts = context.Contacts
	.Where(c => c.Id == id) 
	.Select(c => new { FirstName = c.FirstName, LastName = c.LastName }); 
	
// Dapper: 
var contacts = connection.Query<Contact>( 
	"SELECT Id, FirstName, LastName FROM Contacts WHERE Id = @Id", new { id });
```

---

## Implementation

### NuGet Packages

- Dapper
- Microsoft.Extensions.Configuration
- Microsoft.Extensions.Configuration.Json - for parsing JSON files.

### CRUD

Create Read Update Delete

```c#
// Domain/Interfaces
public interface IModelNameRepository // ModelName in Domain/Models
{
	ModelName Find(int id); // or GetById(string id);
	List<ModelName> GetAll();
	ModelName Add(ModelName entity);
	ModelName Update(ModelName entity);
	void Remove(int id);
}
```

#### Connection Configuration

The SQL connection string `connectionString` is injected through standard Dependency Injection practices for configuration information:
```c#
// Domain/Repositories
using System.Data.SqlClient;

public class ModelNameRepository : IModelNameRepository
{
	private IDbConnection db;

	public ModelNameRepository(string connectionString) // Constructor
	{
		this.db = new SqlConnection(connectionString); // Dependency Injection
	}
	// ...
}
```

```c#
// Presentation/appsettings.json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=.\\sqlexpress;Database=DatabaseName;Trusted_Connection=True"
    // From SQL Express installer: Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True
  }
}
```

```c#
// Presentation/Program.cs
IConfiguration config;

void Initialize()
{
    var builder = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
    config = builder.Build();
}

ITimeRegistrationRepository CreateRepository()
{
    return new TimeRegistrationRepository(config.GetConnectionString("DefaultConnection"));
}
```

#### Create

```c#
public TimeRegistration Add(TimeRegistration entity)
{
    var sql =
        "INSERT INTO TimeRegistrations (Description, Start, Stop) " +
        "VALUES(@Description, @START, @Stop); " +
        "SELECT CAST(SCOPE_Identity() as int)"; // Get id of the inserted row

    var id = _db.Query<int>(sql, entity).Single(); // The actual work
    entity.Id = id; // Assigning the Id we got back to the entity to return.

    return entity;
}
```

Only `INSERT` would be with `_db.Command`, but because of the `SELECT` it needs to be `_db.Query`. With `.Single()` to make sure it is only a single row.

#### Read

##### Read All

All with `*`:
```c#
public List<TimeRegistration> GetAll()
{
    return this._db.Query<TimeRegistration>(
	    "SELECT * FROM TimeRegistration").ToList(); 
}
```

Use Alias to map Table Rows to the Model Properties:
```c#
public List<TimeRegistration> GetAll()
{
    return this._db.Query<TimeRegistration>(
	    "SELECT FirstName FName, LastName FROM TimeRegistration").ToList();
	    // Table Row = FirstName
	    // Model Property = FName
}
```


##### Find

Find by ID:
```c#
public TimeRegistration? Find(int id)
{
	return _db.Query<TimeRegistration>(
		"SELECT * FROM TimeRegistration " +
		"WHERE Id = @Id",
		new { id }) // Can also be written as { Id = id }
		.SingleOrDefault();
}
```


#### Update

```c#
public TimeRegistration Update(TimeRegistration entity)
{
	var sql =
		"UPDATE TimeRegistration " +
		"SET Description = @Description, " +
		"    Start       = @Start, " +
		"    Stop        = @Stop " +
		"WHERE Id = @Id";

	_db.Execute(sql, entity);
	return entity;
}
```

#### Delete

```c#
public void RemoveWithDapper(int id)
{
	_db.Execute(
		"DELETE FROM TimeRegistration " +
		"WHERE Id = @Id", 
		new { id });
}
```


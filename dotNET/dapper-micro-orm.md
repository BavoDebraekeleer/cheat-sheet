# Dapper

## Courses and Documentation

- [Pluralsight: Dapper: Getting Started by Steve Michelotti](https://app.pluralsight.com/library/courses/getting-started-dapper/table-of-contents)
- [GitHub of Dapper with basic documentation.](https://github.com/DapperLib/Dapper)
- [Github: Moq.Dapper](https://github.com/UnoSD/Moq.Dapper/tree/master)

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

## CRUD

Create Read Update Delete.

Dapper.Contrib can be used to simplify the code for standard CRUD operations. Basically hiding the SQL code in a method.
Needs `[Computed]` or `[Write(false)]` attribute for Model Properties that are not part of the Database Table.

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

### Connection Configuration

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

### Create

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

With Dapper.Contrib:
```c#
var id = _db.Insert(entity);
centity.Id = (int)id;
return entity
```

### Read

#### Read All

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

With Dapper.Contrib:
```c#
return _id.GetAll<TimeRegistration>().ToList();
```

#### Find

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

With Dapper.Contrib:
```c#
return _db.Get<TimeRegistration>(id);
```


#### Get Multiple

```c#
public ModelNameOne GetFromTwoTables(int id)
{
	var sql = 
		"SELECT * FROM TableOne WHERE Id = @Id: " +
		"SELECT * FROM TableTwo WHERE TableOneId = @Id";

	using (var multipleResults = _db.QueryMultiple(sql, new { Id = id }))
	{
		var resultFromTableOne = multipleResults.Read<ModelNameOne>()
			.SingleOrDefault();

		var resultFromTableTwo = multipleResults.Read<ModelNameTwo>()
			.ToList();

		if (resultFromTableOne != null && resultFromTableTwo != null)
		{
			resultFromTableOne.ListOfModelNameTwo.AddRange(resultFromTableTwo);
		}
		
		return resultFromTableOne;
	}
}
```


### Update

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

With Dapper.Contrib:
```c#
_db.Update(entity);
return entity;
```


#### Multiple

When updating multiple rows, the method needs to be wrapped in a Transaction, for if anything goes wrong during the multiple operations.

Inside the method, put:
```c#
// At the top, first line in the method:
using var transactionScope = new TransactionScope();

// At the end:
transactionScope.Complete();
```

### Delete

```c#
public void RemoveWithDapper(int id)
{
	_db.Execute(
		"DELETE FROM TimeRegistration " +
		"WHERE Id = @Id", 
		new { id });
}
```

With Dapper.Contrib:
```c#
return _db.Delete(new TimeRegistration { Id = id });
```

By the model name, it knows which table to go to, assuming the names are the same.

---

## Async

- Make method `async`.
- Place return type in `Task<>` to set as `TResult`.
- Use `await` in front of database connection call.
- Use async Dapper function, like `QueryAsync` or `ExecuteAsync`.

Find by ID:
```c#
public async Task<TimeRegistration?> FindWithDapperAsync(int id)
{
	var sql = "SELECT * FROM TimeRegistration WHERE Id = @Id";
	var result = await _db.QueryAsync<TimeRegistration>(sql, new { id });
	return result.SingleOrDefault();
}
```

---

## Stored Procedures and Dynamic Parameters

Specify the SQL code within the Database itself, in the folder Stored Procedures.

![[Pasted image 20231017213321.png]]

### SQL CRUD Stored Procedures

```sql
-- Database/Stored Procedures/GetTimeRegistration
CREATE PROCEDURE [dbo].[GetTimeRegistration]
	@Id int
AS
BEGIN
	SELECT [Id]
		  ,[Description]
		  ,[Start]
		  ,[Stop]
	FROM [dbo].[TimeRegistration]
	WHERE Id = @Id;
END;
```

```sql
-- Database/Stored Procedures/SaveTimeRegistration
CREATE PROCEDURE [dbo].[SaveTimeRegistration]
	@Id				int output,
	@Description	varchar(50),
	@Start			datetime,
	@Stop			datetime
AS
BEGIN
	UPDATE TimeRegistration
	SET	   Description = @Description,
		   Start	   = @Start,
		   Stop		   = @Stop
	WHERE  Id		   = @Id

	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO [dbo].[TimeRegistration]
			([Description]
			,[Start]
			,[Stop])
		VALUES
			(@Description
			,@Start
			,@Stop)
		SET @Id = cast(scope_identity() as int)
	END;
END;

```

```sql
-- Database/Stored Procedures/DeleteTimeRegistration
CREATE PROCEDURE [dbo].[DeleteTimeRegistration]
	@Id int
AS
BEGIN
	DELETE FROM TimeRegistration
	WHERE Id = @Id;
END;
```

### Usage with Dapper and Dynamic Parameters

```c#
public TimeRegistration? FindWithDapper(int id)
{
	return _db.Query<TimeRegistration>(
		"GetTimeRegistration",
		new { id },
		commandType: CommandType.StoredProcedure)
		.SingleOrDefault();  // Only give the first result, even if multiple.
}
```


```c#
public void SaveWithDapper(TimeRegistration entity)
{
	var parameters = new DynamicParameters();
	parameters.Add( // Id is Primary Key and input/output parameter
		"@Id", 
		value: entity.Id, 
		dbType: DbType.Int64, 
		direction: ParameterDirection.InputOutput);
	parameters.Add("@DDescription", entity.Description);
	parameters.Add("@Start", entity.Start);
	parameters.Add("@Stop", entity.Stop);

	_db.Execute(
		"SaveTimeRegistration", 
		parameters, 
		commandType: CommandType.StoredProcedure);
	
	entity.Id = parameters.Get<int>("@Id");
}
```


```c#
    public void RemoveWithDapper(int id)
    {
        _db.Execute(
	        "DeleteTimeRegistration", // The name of the SQL script
	        new { id },  // Same as before
	        commandType: CommandType.StoredProcedure); // Tell to look for an SP
    }
```

---

## List for IN Operator

Method:
```c#
public List<ModelName> GetById(params int[] ids)
{
	return _db.Query<ModelName>(
		"SELECT * FROM " +
		"WHERE ID IN @Ids",
		new { Ids = ids })
		.ToList();
}
```

Usage:
```c#
List<ModelName> list = repository.GetById(1, 2, 5);
```

---

## Dynamic

Method:
```c#
public List<dynamic> GetById(params int[] ids)
{
	return _db.Query(
		"SELECT * FROM " +
		"WHERE ID IN @Ids",
		new { Ids = ids })
		.ToList();
}
```

Usage:
```c#
var list = repository.GetById(1, 2, 5);
```

---

## Multi Mapping

For One-to-One or One-to-Many relations.

*Example:*
```c#
public List<Contact> GetAllContactsWithAddresses()
{
    var sql = 
	    "SELECT * FROM Contacts AS C " +
	    "INNER JOIN Addresses AS A " +
	    "ON A.ContactId = C.Id";

    var contactDict = new Dictionary<int, Contact>();

    var contacts = this.db.Query<Contact, Address, Contact>(
	    sql, (contact, address) =>
    {
        if (!contactDict.TryGetValue(contact.Id, out var currentContact))
        {
            currentContact = contact;
            contactDict.Add(currentContact.Id, currentContact);
        }

        currentContact.Addresses.Add(address);
        return currentContact;
    });
    return contacts.Distinct().ToList();
}
```

---






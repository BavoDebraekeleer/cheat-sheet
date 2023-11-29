# ASP .NET Core API

## Courses

- [Pluralsight Path: ASP.NET Core 6 Web API](https://app.pluralsight.com/paths/skills/aspnet-core-6-web-api)
- [Pluralsight: ASP.NET Core 6 Web API Fundamentals by Kevin Dockx](https://app.pluralsight.com/library/courses/asp-dot-net-core-6-web-api-fundamentals/table-of-contents)
- [Blog Post: Service Lifetimes in ASP.NET Core by Elisenda Gascon](https://endjin.com/blog/2022/09/service-lifetimes-in-aspnet-core)
- [Dependency Injection and Service Lifetimes in .NET Core by Henrique Siebert Domareski](https://henriquesd.medium.com/dependency-injection-and-service-lifetimes-in-net-core-ab9189349420)
- [Best Practices for Designing a Pragmatic RESTful API by Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api)
- [Microsoft Learn: Controller action return types in ASP.NET Core web API](https://learn.microsoft.com/en-us/aspnet/core/web-api/action-return-types?view=aspnetcore-7.0)
- [Pluralsight: ASP.NET Core 6 Web API Deep Dive by Kevin Dockx](https://app.pluralsight.com/library/courses/asp-dot-net-core-6-web-api-deep-dive/table-of-contents)


---
## ASP .NET Core

ASP .NET Core is a Web Application Framework, combining frontend and backend.

![[Pasted image 20231016213353.png]]
![[Pasted image 20231016213421.png]]
![[Pasted image 20231016213444.png]]
![[Pasted image 20231016213749.png]]

### Dependency Injection

### Overview

The dependency injection container is a tool that manages the instantiation and configuration of objects in an application. Even though it is technically possible to build an application without using the principle of inversion of control, the use of a container is always recommended to simplify the management of dependencies within your code.

At startup, services are registered in the container. Whenever these services are required, instances of those services are resolved from the container at runtime. The container is responsible for the creation and disposal of instances of the required services, by keeping track of them and maintaining them for the duration of their lifetime.

![[Pasted image 20231016213859.png]]
![[Pasted image 20231016213937.png]]

Benefits:
- Removes hardcoded dependencies and allows them to be changed.
- Allows the developer to write loosely coupled code, making applications easier to maintain, extend, and test.
- Increase the testability in software applications that use DI. Loosely coupled code can be tested more easily. It’s easier to make a change in the code without affecting other areas of the application. With DI, it’s possible to inject mocked dependencies in the tests.
- Developers can work on different pieces of functionality in parallel, since the implementations are independent of each other.
- Improve the readability and cleanliness of the code.


### Usage Example

Service class using an Interface:
```c#
public class CategoryRepository : ICategoryRepository
{
    public Category GetCategory()
    {
        return new Category();
    }
}

public interface ICategoryRepository
{
     Category GetCategory();
}
```

Configuration: Service registration in ``Program.cs``:
```c#
public void ConfigureServices(IServiceCollection services)
{
    services.AddScoped<ICategoryRepository, CategoryRepository>();
}
```

Usage: When an instance is needed, put it in the constructor of where you need it, and DI will inject an instance into the constructor:
```c#
public class CategoryService
{
    private readonly ICategoryRepository _categoryRepository;

    public CategoryService(ICategoryRepository categoryRepository)
    {
        _categoryRepository = categoryRepository;
    }
}
```

Setting the property as a `readonly` property will avoid the possibility of other methods accidentally assigning a different value for this dependency.

With DI, the code is not depending on a concrete class (the code does not depends on the class “CategoryRepository”) but depends on an abstraction (the “ICategoryRepository). The CategoryService is not using the concrete type “CategoryRepository”, only use the “ICategoryRepository” interface it implements.

This makes it easy to change the implementation of the CategoryRepository, which is used by the service class, without modifying the service class itself. Also, the service class does not create an instance of “CategoryRepository”, it is only created by the DI container. This way the code is loosely coupled, so even if something is changed in the concrete class (CategoryRepository), it will not break the code on the CategoryService, because this code only depends on its abstraction.

The dependency injection container keeps track of all instances of the created services, and they are disposed of or released for garbage collector once their lifetime has ended.


### Service Lifetimes

Control how long the container will hold onto a resolved object after creating it.
The lifetime of the service is specified when registering the service in the container.

There are ***three*** lifetimes available with the Microsoft Dependency Injection container: 
- transient,
- singleton,
- and scoped.

The service lifetime will affect whether the same instance of the service is consumed across the application, thus affecting the output.

#### Transient Lifetime

An instance of the registered service is created when injected into a class.

Use `AddTransient` extension method on the `IServiceCollection`:
```c#
builder.Services.AddTransient<IServiceName, ServiceName>();
```


#### Singleton Lifetime

Only instanced once during the lifetime of the application.

Use `AddSingleton` extension method on the `IServiceCollection`:
```c#
builder.Services.AddSingleton<IServiceName, ServiceName>();
```


#### Scoped Lifetime

When an HTTP request is sent to the server, an `HttpContext` is created, which holds information on the request. This is when a scope for the current request is created within the application. The `HttpContext` is then sent through the request pipeline, which includes several middleware components as well as endpoints, which generate the final response.

This definition of a scope is important to understand scoped lifetimes. In ASP.NET Core, the lifetime of a scope is equivalent to the lifetime of an HTTP request. Services registered with a scoped lifetime will be maintained and used during the lifetime of the scope (or HTTP request) they have been created in. So for one same request, the instance of an object injected in different classes will be the same.

Use `AddScoped` extension method on the `IServiceCollection`:
```csharp
builder.Services.AddScoped<IServiceName, ServiceName>();
```


#### `InvalidOperationException`

Capturing a short-lived service inside of a longer-lived service will result in an `InvalidOperationException` being thrown because instances of the services can't be correctly injected.

The way to solve this is to inject services as parameters in the `Invoke` or `InvokeAsync` method of the middleware component. As this method will be invoked once per request, its parameters will be resolved from the container within the scope of the current request.


---

## API Standards

![[Pasted image 20231016220945.png]]
![[Pasted image 20231016221027.png]]
![[Pasted image 20231016221054.png]]


### RESTfull Web API with Controller Pattern

Standard from outside .NET.

![[Pasted image 20231016214314.png]]
![[Pasted image 20231016214349.png]]


### Minimal API

Specify endpoints directly in the pipeline.
Without the build-in functionalities of a controller, e.g. validation.

![[Pasted image 20231016215535.png]]
![[Pasted image 20231016215555.png]]

### gRPC

Standard from outside .NET.
Tighter coupling.

![[Pasted image 20231016215909.png]]

#### Contract

Focus on performance, gives numbers to the properties in the models for seriealization.
For example, the Product in the following code:

![[Pasted image 20231016220040.png]]
![[Pasted image 20231016220151.png]]

![[Pasted image 20231016220424.png]]

### SignalR

Has the ability to call Client side methods from the backend server, e.g. to update products on a page.

1. Client calls the HUB on the backend server:![[Pasted image 20231016221825.png]]
2. Hub calls the method on all Clients:![[Pasted image 20231016221841.png]]

![[Pasted image 20231016221344.png]]

---

## Request Pipeline and Middleware

A Request Pipeline is what handles a HTTP Request when it comes in, to provide a Response. It is made up off Middleware that handle the request.

Middleware are software components that are assembled into an application pipeline, 
to handle requests and responses. For example, for authentication, or diagnostics.

![[Pasted image 20231018121237.png]]

Important to note is that Middleware can choose whether to pass their response on to the next Middleware, or not. So the order is critical.

![[Pasted image 20231018121216.png]]


## Model-View-Controller (MVC)

Architectural software pattern for implementing user interfaces.
Not a full application architecture pattern, like Clean Architecture.

Benefits:
- Loose coupling
- Separation of concerns
- Testability
- Reusability

MVC:
- Model – application data logic, e.g., how data is stored in a database.
- View – Handles displaying a representation of data to the user. For an API, this representation can be a JSON object.
- Controller – Handles the interaction between the View and the Model, including user input.

![[Pasted image 20231018141013.png]]

---

## [Routing](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/routing?view=aspnetcore-7.0)

Routing matches a request URI to an action on a controller.

Middleware that runs in between selecting the endpoint and executing the selected endpoint can be injected.

```c#
app.UseHttpsRedirection();
app.UseRouting(); // Position where routing decision is made.
app.UseAuthorization();
app.UseEndpoints(endpoints => { // Position where selected endpoint is executed.
	endpoints.MapControllers(); // Maps the controller endpoints.
});
```

Base setup for API in .NET 6 can be done with the following, instead of the above:
```c#
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers(); // Request pipeline setup and route mannagement in one.
```


### Attribute-based Routing

Mapping the API routing endpoints is done by using attributes:
```c#
[Route("api/[controller]")] // Controller attribute
[ApiController]
public class NameController : ControllerBase
{
    [HttpGet(Name = "GetTimeRegistration")] // HTTP Action attribute
    public ModelName Get()
    {
        throw new NotImplementedException();
    }
}
```

The `[controller]` attribute, in the Route attribute string, has the effect of taking the name of the controller class before the `Controller` part in the name. However, when you change the class name, the URI changes with it, which is not desirable in an API. You want the URI's to stay the same, separated from code changes. (Note, it is also case-sensitive.)

![[Pasted image 20231018142833.png]]

---

## Status Codes

5 levels:
- 100 – Informational (not for API's)
- 200 – Success
- 300 – Redirection (not for API's)
- 400 – Client mistake

The most important status codes:
- 200 – OK
- 201 – Created
- 204 – No Content (e.g. Delete)

- 301 – Permanent Redirect
- 302 – Temporary Redirect

- 400 Bad Request
- 401 – Unauthorized
- 403 – Forbidden (e.g. authenticated user has no access)
- 404 – Not Found
- 409 – Conflict (e.g. conflict between two simultaneous updates)
- 410 – Gone

- 500 – Internal Server Error
- 503 – Service Unavailable

The ones to definitely use in an API are:
- 200 OK – Response to a successful GET, PUT, PATCH or DELETE. Can also be used for a POST that doesn't result in a creation.
- 201 Created – Response to a POST that results in a creation. Should be combined with a [Location header](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.30) pointing to the location of the new resource
- 204 No Content – Response to a successful request that won't be returning a body (like a DELETE request)
- 304 Not Modified – Used when HTTP caching headers are in play
- 400 Bad Request – The request is malformed, such as if the body does not parse
- 401 Unauthorized – When no or invalid authentication details are provided. Also useful to trigger an auth pop-up if the API is used from a browser
- 403 Forbidden – When authentication succeeded but authenticated user doesn't have access to the resource
- 404 Not Found – When a non-existent resource is requested
- 405 Method Not Allowed – When an HTTP method is being requested that isn't allowed for the authenticated user
- 410 Gone – Indicates that the resource at this end point is no longer available. Useful as a blanket response for old API versions
- 415 Unsupported Media Type – If incorrect content type was provided as part of the request
- 422 Unprocessable Entity – Used for validation errors
- 429 Too Many Requests – When a request is rejected due to rate limiting.


See [Microsoft Learn: Controller action return types in ASP.NET Core web API](https://learn.microsoft.com/en-us/aspnet/core/web-api/action-return-types?view=aspnetcore-7.0) on how to set them up.

---
## Formatters and Content Negotiation

Content Negotiation is the process of selecting the best representation for a given response when there are multiple representations available.

Media types are:
- `application/json` – the response should be formatted as JSON.
- `application/xml` – the response should be formatted as XML.
- non - default formatting (usually JSON).

For Output Formatters, the media types are passed through via the Accept header.
For Input Formatters, the media types are passed through the Content-Type header.

![[Pasted image 20231018175030.png]]

Support is implemented by `ObjectResult`.

#### Configuration

```c#
builder.Services.AddControllers(options =>
{
    options.ReturnHttpNotAcceptable = true;
    // Content Negotiation: if Formatter is not available, returns 406.
}).AddXmlDataContractSerializerFormatters(); // Adds XML Formatter
```


---

## File Controller

```c#
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;

namespace CityInfo.API.Controllers
{
    [Route("api/files")]
    [Authorize]
    [ApiController]
    public class FilesController : ControllerBase
    {

        private readonly FileExtensionContentTypeProvider _fileExtensionContentTypeProvider;

        public FilesController(
            FileExtensionContentTypeProvider fileExtensionContentTypeProvider)
        {
            _fileExtensionContentTypeProvider = fileExtensionContentTypeProvider
                ?? throw new System.ArgumentNullException(
                    nameof(fileExtensionContentTypeProvider));
        }

        [HttpGet("{fileId}")]
        public ActionResult GetFile(string fileId)
        {
            // look up the actual file, depending on the fileId...
            // demo code
            var pathToFile = "getting-started-with-rest-slides.pdf";

            // check whether the file exists
            if (!System.IO.File.Exists(pathToFile))
            {
                return NotFound();
            }

            if (!_fileExtensionContentTypeProvider.TryGetContentType(
                pathToFile, out var contentType))
            {
                contentType = "application/octet-stream";
            }

            var bytes = System.IO.File.ReadAllBytes(pathToFile);
            return File(bytes, contentType, Path.GetFileName(pathToFile));
        }
    }
}

```

To specify content types:
```c#
// Program.cs
builder.Services.AddSingleton<FileExtensionContentTypeProvider>();
```

---

## HTTP Actions

### Creation

#### HTTP Post – Create

Creation with POST is not idempotent.
When posting the same resource multiple times, a new one gets created each time, but with a different ID.

### Upserting

The principle that when updating a resource that does not exist yet, it is created.
When it does exist it is only updated, it is idempotent.

![[Pasted image 20231114150100.png]]

#### HTTP Put – Update
#### HTTP Patch – Partial Update

For partially updating an entity, a JSON Patch (RFC 6902) Document is used.
It is a document structure that describes a sequence of operations to apply to a JSON document.

```json
[
	{
		"op": "replace",
		"path": "/name",
		"value": "new name"
	},
	{
		"op": "add",
		"path": "/description",
		"value": "new description"
	}
]
```

Needed packages: 
- `Microsoft.AspNetCore.JsonPatch`
- `Microsoft.AspNetCore.Mvc.NewtonsoftJson`


---

## Filtering, Searching and Paging

### Filtering

Filtering a collection means *limiting* a collection by using a predicate.
For example, `https://host/api/cities?name=Antwerp`.
The *predicate* here is `?name=Antwerp`.

Used for exact results, when you know what you want exactly.

### Searching

Searching a collection means *adding* matching items to the collection based on a predefined set of rules.
For example, `https://host/api/cities?searchQuery=Tower`.
Here, with the use of a query string.

Used when you don't know exactly which items will be in the collection.

### Deferred Execution

Query execution occurs sometime after the query is constructed with Entity Framework.
We build the query by chaining methods with EF. It only gets executes when calling an execution method, like `.ToListAsync()`.

![[Pasted image 20231028155120.png]]

### Paging

Limit results to a certain amount, avoiding large queries that are heavy on performance.
For example, `https://host/api/cities?pageNumber=1&pageSize=5`.
Also via a query string, here `?pageNumber=1&pageSize=5`.

Important:
- Page size should be limited.
- Return page one by default.
- Page all the way through to the underlying database.

#### Implementation

1. Add parameters with default values on Controller function
```c#
int pageNumber = 1, int pageSize = 10, // Paging parameters
```

2. Add `pageSize` limit on Controller:
```c#
// Controller field
private const int maxPageSize = 20;

...

// In function
if (pageSize > maxPageSize) // Limit page size for Paging
{
    pageSize = maxPageSize;
}
```

3. Add parameters on Repository and its Interface.
```c#
int pageNumber, int pageSize
```

4. In EF, add `.Skip(pageSize * (pageNumber - 1))` last, but before `.ToListAsync();`.
```c#
    public async Task<List<TimeRegistrationEntity>?> GetAllWithEF(
	    int pageNumber, int pageSize)
    {
        return await _dbContext.TimeRegistration
            .OrderBy(entity => entity.UserId) // Order by needs to happen first!
            .Skip(pageSize * (pageNumber - 1))
            .Take(pageSize)
            .ToListAsync();
    }
```

Results in Query:
```sql
SELECT [t].[Id], [t].[Description], [t].[Start], [t].[Stop], [t].[UserId]
FROM [TimeRegistration] AS [t]
ORDER BY [t].[UserId]
OFFSET @__p_0 ROWS FETCH NEXT @__p_1 ROWS ONLY
```

4. In [SQL](https://www.sqlshack.com/pagination-in-sql-server/), with Dapper:
```c#
public async Task<List<TimeRegistrationEntity>?> GetAllWithDapper(
	int pageNumber, int pageSize) // Read with Dapper
{
    var result = await _dbConnection.QueryAsync<TimeRegistrationEntity>(
        """
        SELECT 
            Id, 
            UserId, 
            Description, 
            Start, 
            Stop 
        FROM 
            [dbo].[TimeRegistration] 
        ORDER BY // Needs to happen before OFFSET
            Id
        OFFSET (@pageSize * (@pageNumber - 1)) ROWS
        FETCH NEXT @pageSize ROWS ONLY;
        """,
        new { pageNumber, pageSize }
    );
    
    if (result is not null)
    {
        return result.ToList();
    }
    return null;
}
```

Example GET string:
```bash
https://localhost:7136/api/v1/time-registrations?pageNumber=1&pageSize=5
```

#### Pagination Metadata

Use a custom header for Pagination Metadata, like `X-Pagination`.

Steps:
1. Make a class that describes `PaginationMetadata`.
2. Implement in Repository and return the metadata object alongside the result in a tuple.
3. Implement in Controller by serialize the metadata object to JSON and adding it to the response header, e.g., `Response.Headers.Add("HeaderName", JsonSerializer.Serialize(paginationMetadata));`

---

## Security

### [CORS Policy](https://learn.microsoft.com/en-us/aspnet/core/security/cors?view=aspnetcore-7.0#attr)

```c#
// Program.cs
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(
        policy =>
        {
            policy.WithOrigins("http://localhost:????/"); // Fill in port nr
            
            policy.AllowAnyOrigin();
            policy.AllowAnyHeader();
            policy.AllowAnyMethod();
        });
});

...

app.UseCors();
```

---

## Validation

Using built-in systems of ASP.NET `[ApiController]` like `IValidatableObject` and `ValidationAttribute`
Or by using a library like `FluentValidation`.

### Overview

![[Pasted image 20231114133113.png]]

#### Reporting Validation Errors

A validation error is a client-side mistake, so 400 range status code.

- ***400 'Bad Request'*** [RFC 7231](https://datatracker.ietf.org/doc/html/rfc7231) can be used in any situation where the server perceives a client error, even if the request syntax is valid.

- ***442 'Unprocessable Entity'*** [RFC7807](https://datatracker.ietf.org/doc/html/rfc7807) is used when the server understands the content type of the request entity, and the syntax of the request entity is correct, but it is unable to process the contained instructions due to semantic errors. The request was semantically erroneous and should not be retried without modification.
  It may be used for validation errors, business logic errors, authorization errors (user not authorized to perform action), and data conflicts (conflict with existing data).

- ***409 'Conflict'*** indicates a conflict based on the current state of the target resource, which can be resolved by the user. The request from the client was fine, but there were issues on the server-side that prevents the request from being executed. In other words, the client was not able to successfully create or update a resource due to a conflict with the current state of the resource, for example, overlapping time registrations in a timesheet.

[More info and explanations](https://www.abstractapi.com/http-status-codes/422#:~:text=The%20409%20status%20code%20indicates,not%20be%20retried%20without%20modification.)
[And some more](https://www.webfx.com/web-development/glossary/http-status-codes/what-is-a-422-status-code/)


### Validation on API Controller Level
#### Defining Validation Rules

Using:
- Data annotation, built-in or custom.
- `IValidatableObject`

#### Checking Validations

Using:
- `ModelState`:
	- A dictionary containing both the:
		- State of the model, and the
		- Model Binding Validation
	- Contains a collection of error messages for each property value submitted.
- `ModelState.IsValid()`: for checking.

#### Reporting Validation Errors

The [RFC7807](https://datatracker.ietf.org/doc/html/rfc7807) is the standard for reporting validation errors on Controller level.
It defines common error formats for those applications that need one, to provide a format that can be automatically parsed, read, and reacted to by the client-side app.

A validation error is a client-side mistake, so 400 range status code.
Response status code should be ***442 Unprocessable Entity***, meaning the syntax is correct, but there is a semantics error, like validation.
Response body should contain validation errors.


#### `[ApiController]`

By default, the  `ApiController` automatically sends a 400 Bad Request status code on validation errors, which is ok, but 442 Unprocessable Entity is better.

400 example:
![[Pasted image 20231114140056.png]]

422 example:
![[Pasted image 20231114140131.png]]

##### Custom Error Messages

```c#
// In DTO
[Required(ErrorMessage = "This property is required")]
[MaxLength(100, ErrorMessage = "This string should be max 100 chars.")]
public string PropertyName { get; set; } = String.Empty;
```

##### Setup for Custom Response Object


```c#
// Program startup
builder.Services.AddControllers(configure =>
{
	configure.ReturnHttpNotAcceptable = true;
})
.ConfigureApiBehaviorOptions(setupAction =>
{
	setupAction.InvalidModelStateResponseFactory = context =>
	{
		// Create a validation problem details object:
		var problemDetailsFactory = context.HttpContext.RequestServices
			.GetRequiredService<ProblemDetailsFactory>();
		var validationProblemDetails = problemDetailsFactory
			.CreateValidationProblemDetails(
				context.HttpContext,
				context.ModelState
			);

		// Add additional info not added by default:
		validationProblemDetails.Detail = 
			"See the error field for details.";
		validationProblemDetails.Instance = 
			context.HttpContext.Request.Path;

		// Report invalid model state responses as validation issues:
		validationProblemDetails.Type = 
			"url";
		validationProblemDetails.Status = 
			StatusCodes.Status422UnprocessableEntity;
		validationProblemDetails.Title = 
			"One or more validation errors occurred.";

		return new UnprocessableEntityObjectResult(validationProblemDetails)
		{
			ContentTypes = { "application/problem+json" }
		};
	};
});
```

##### `IValidatableObject`

Interface to be used on DTOs to implement a Validation method for cross-property validation rules.

First, the property validation rules get checked. By default, only if those are valid does the validation method get called.

Example:
```c#
public abstract class CourseSaveDTO : IValidatableObject
{
	...

    public IEnumerable<ValidationResult> Validate(
	    ValidationContext validationContext)
    {
        if (Title == Description)
        {
	        yield return new ValidationResult(
		        "The procided description should be different from title."
		        new[] { "Course" }
	        );
        }
    }
}
```


##### `ValidationAttribute`

Define new attributes as classes in a separate folder.

![[Pasted image 20231114151313.png]]

Example class implementation:
```c#
using System.ComponentModel.DataAnnotations;
...

public class RegistrationMaxHoursPerDayShouldNotExceed8 : ValidationAttribute
{
    protected override ValidationResult? IsValid(
	    object? value, ValidationContext validationContext)
    {
        // Check if attribute is applied to the correct type.
        if (validationContext.ObjectInstance is not 
	        RegistrationSaveDTO registration)
        {
            throw new Exception($"Attribute {nameof(RegistrationMaxHoursPerDayShouldNotExceed8)} should be applied to a {nameof(RegistrationSaveDTO)} or derived type.");
        }

        // Validation business rules.
        var timeSpan = registration.End.Subtract(registration.Start);
        if (timeSpan.TotalHours > 8)
        {
            return new ValidationResult(
                "Time exceeds max of 8h per day.",
                new[] { nameof(RegistrationSaveDTO) }
            );
        }

        return ValidationResult.Success;
    }
} 
```

Apply to a DTO class:
```c#
[RegistrationMaxHoursPerDayShouldNotExceed8]
public abstract class RegistrationSaveDTO {..}
```

##### Override ValidationProblem in a Controller

To make sure the 422 response configured in Program, by default only for models, is used instead of the default 400 when doing validation in the controller.

```c#
public override ActionResult ValidationProblem(
	[ActionResultValueObject] ModelStateDictionary modelStateDictionary
)
{
	var options = HttpContext.RequestServices
		.GetRequiredService<IOptions<ApiBehaviorOptions>>();
	return (ActionResult)options.Value
		.InvalidModelStateResponseFactory(ControllerContext);
}
```

Example usage:
```c#
if (!TryValidateModel(entityToPatch))
{
	return ValidationProblem(ModelState);
}
```


#### [`FluentValidation` Library](https://docs.fluentvalidation.net/en/latest/)


### Domain Validation

[Microsoft Learn: Design validations in the domain model layer](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/domain-model-layer-validations)
[Microsoft Learn: Handle errors in ASP.NET Core web APIs](https://learn.microsoft.com/en-us/aspnet/core/web-api/handle-errors?view=aspnetcore-8.0)
[DEPRECATED! Code Maze: Using the ProblemDetails Class in ASP.NET Core Web API](https://code-maze.com/using-the-problemdetails-class-in-asp-net-core-web-api/)
[YouTube: Domain Validation With .NET | DDD, .NET 6 — Milan Jovanović](https://www.youtube.com/watch?v=KgfzM0QWHrQ)
[YouTube: How To Implement Validation With MediatR And FluentValidation — Milan Jovanović](https://www.youtube.com/watch?v=85dxwd8HzEk)

Multiple approaches, all with their own benefits and problems:
- Exception Throwing (easiest)
- Result Objects with the Specification and Notification Patterns (better maintainable)

### Exception Throwing

#### Validation and Throwing the Exceptions

Steps:
1. Create a custom Exception for your needs:
```c#
// Domain/Exceptions/AppException.cs
using System.Globalization;

namespace TimesheetApp.Domain.Exceptions
{
    // custom exception class for throwing application specific exceptions (e.g. for validation)
    // that can be caught and handled within the application
    public class AppException : Exception
    {
        public AppException() : base() { }

        public AppException(string message) : base(message) { }

        public AppException(string message, params object[] args)
            : base(string.Format(
	            CultureInfo.CurrentCulture, message, args)) { }
    }
}

```

2. Throw this Exception, with a clear message of the problem, if a validation error occurs in the appropriate aggregate root domain model, for example:
```c#
public static bool ValidateDayHasMax8h(Registration registration)
{
    var timeSpan = registration.TimeSlot.End.Subtract(
	    registration.TimeSlot.Start);
    
    if (timeSpan.TotalHours > 9) // 8h + 1h break
    {
        throw new BusinessRuleValidationAppException(
            $"By adding this registration, the time span between start and end exceeds the maximum of 8 hours per day, plus an hour break, by {timeSpan.TotalHours - 8.5}.",
            new[] { nameof(Registration) }
        );
    }
    return true;
}
```

#### Catching and Handling the Exceptions

Steps:
1. Defining an Error Handler:
```c#
// Application/ErrorHandler/ErrorHandlerMiddleware
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.Net;
using System.Text.Json;
using TimesheetApp.Domain.Exceptions;

namespace TimesheetApp.Application.ErrorHandler
{
    public class ErrorHandlerMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ErrorHandlerMiddleware> _logger;

        public ErrorHandlerMiddleware(
	        RequestDelegate next, ILogger<ErrorHandlerMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception error)
            {
                var response = context.Response;
                response.ContentType = "application/json";

                switch (error)
                {
                    case BusinessRuleValidationAppException e:
                        response.StatusCode = (int)HttpStatusCode.Conflict;
                        _logger.LogError(e.ToString());
                        break;
                    case AppException e:
                        response.StatusCode = (int)HttpStatusCode.BadRequest;
                        _logger.LogError(e.ToString());
                        break;
                    case KeyNotFoundException e:
                        response.StatusCode = (int)HttpStatusCode.NotFound;
                        _logger.LogInformation(e.ToString());
                        break;
                    case UnauthorizedAccessException e:
                        response.StatusCode = (int)HttpStatusCode.Unauthorized;
                        _logger.LogInformation(e.ToString());
                        break;
                    default:
                        response.StatusCode = (int)HttpStatusCode.InternalServerError;
                        _logger.LogError(error.ToString());
                        break;
                }

                var result = JsonSerializer.Serialize(new { message = error?.Message });
                await response.WriteAsync(result);
            }
        }
    }
}

```

2. Setup using the Error Handler:
```c#
// API/Program.cs
builder.Services.AddControllers(configure =>
{
    configure.ReturnHttpNotAcceptable = true;
})
.ConfigureApiBehaviorOptions(setupAction =>
{
    setupAction.SuppressMapClientErrors = true;
});

...

app.UseExceptionHandler();
app.UseStatusCodePages();

// global error handler
app.UseMiddleware<ErrorHandlerMiddleware>();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
```

---

## Events

[Medium: Domain Events in .Net Core using the MediatR Library — Charles](https://medium.com/@cizu64/using-mediatr-for-domain-events-in-net-core-9750a3406444#:~:text=The%20domain%20event%20handler%20defines,defined%20in%20the%20application%20layer.) [GitHub source code for the above](https://github.com/cizu64/School)
[Microsoft Learn: Handle and raise events](https://learn.microsoft.com/en-us/dotnet/standard/events/)
[Microsoft Learn: How to Raise and Consume Events (Examples)](https://learn.microsoft.com/en-us/dotnet/standard/events/how-to-raise-and-consume-events)
[Medium: Implementing Event Sourcing and CQRS with ASP.NET Core](https://medium.com/@craftingcode/implementing-event-sourcing-and-cqrs-with-asp-net-core-in-microservices-b2563f04fe13)

### Events with MediatR

![[Pasted image 20231129102333.png]]

Messages should be sent from the aggregate root entity.

#### Steps
##### Domain Layer

1. Create an abstract base class for aggregate roots that has an `INotification` list from MediatR to hold the Domain Events in `Domain/Models`:
```cs
using MediatR;

namespace TimesheetApp.Domain.Models;

public abstract class AggregateRoot
{
    private List<INotification> _domainEvents = new List<INotification>();
    public IReadOnlyCollection<INotification> DomainEvents => _domainEvents.AsReadOnly();

    public void AddDomainEvent(INotification eventItem)
    {
        _domainEvents.Add(eventItem);
    }

    public void RemoveDomainEvent(INotification eventItem)
    {
        _domainEvents.Remove(eventItem);
    }

    public void ClearDomainEvents()
    {
        _domainEvents.Clear();
    }
}
```

2. Create a Domain Event class in `Domain/Events`:
```cs
using MediatR;

namespace TimesheetApp.Domain.Events;

public class RegistrationSubmittedDomainEvent(string employeeId, int timesheetId, List<int> registrationIds) : INotification
{
    public string EmployeeId { get; private set; } = employeeId;
    public int TimesheetId { get; private set; } = timesheetId;
    public List<int> RegistrationIds { get; private set; } = registrationIds;
}
```

3. Add the domain event where it needs to be raised in the Aggregate Root Entity class:
```cs
public void SubmitWeek(int timesheetYear, int timesheetMonth, List<int> registrationIds)
{
    var timesheet = GetTimesheet(timesheetYear, timesheetMonth);
    timesheet.Submit(registrationIds);

    AddDomainEvent(new RegistrationSubmittedDomainEvent(
	    this.Id, timesheet.Id, registrationIds));
}
```

##### Application Layer

4. Define what needs to happen when the Domain Event is raised in an `INotificationHandler` class in `Application/DomainEventHandlers`:
```cs
using MediatR;
using Microsoft.Extensions.Logging;
using TimesheetApp.Application.ErrorHandler;
using TimesheetApp.Domain.Events;

namespace TimesheetApp.Application.EventHandler;

public class RegistrationSubmittedDomainEventHandler(
	ILogger<ErrorHandlerMiddleware> logger) : 
	INotificationHandler<RegistrationSubmittedDomainEvent>
{
    private readonly ILogger<ErrorHandlerMiddleware> _logger = logger;

    public async Task Handle(
	    RegistrationSubmittedDomainEvent notification, 
	    CancellationToken cancellationToken)
    {
        string logMessage = "Submitted Registrations [";
        notification.RegistrationIds.ForEach(registrationId =>
        {
            logMessage += $"{registrationId}, ";
        });
        logMessage.Remove(logMessage.Length - 2);
        logMessage += $"] from Timesheet {notification.TimesheetId} from Employee {notification.EmployeeId}.";

        _logger.LogInformation(logMessage);
    }
}
```

##### Infrastructure Layer

5. Create an extensions class for MediatR to dispatch the Domain Events in `Infrastructure/Extensions`:
```cs
using CSharpFunctionalExtensions;
using MediatR;
using System.Linq;
using System.Threading.Tasks;
using TimesheetApp.Domain.Models;
using TimesheetApp.Infrastructure;

namespace School.Infrastructure.Extensions
{
    static class MediatorExtensions
    {
        public static async Task DispatchDomainEventsAsync(
	        this IMediator mediator, AppDbContext ctx)
        {
            var domainAggregateRoots = ctx.ChangeTracker
                .Entries<AggregateRoot>()
                .Where(x => x.Entity.DomainEvents != null && x.Entity.DomainEvents.Any());

            var domainEvents = domainAggregateRoots
                .SelectMany(x => x.Entity.DomainEvents)
                .ToList();

            domainAggregateRoots.ToList()
                .ForEach(entity => entity.Entity.ClearDomainEvents());

            foreach (var domainEvent in domainEvents)
                await mediator.Publish(domainEvent);
        }
    }
}
```

6. Call the mediator extension method on saving the state changes in the DbContext:
```cs
using MediatR;
using Microsoft.EntityFrameworkCore;
using School.Infrastructure.Extensions;
using System.Reflection;
using TimesheetApp.Domain.Models;

namespace TimesheetApp.Infrastructure;

public class AppDbContext(
	DbContextOptions<AppDbContext> options, IMediator mediator) : 
	DbContext(options)
{
    private readonly IMediator _mediator = mediator;

    protected override void OnConfiguring(
	    DbContextOptionsBuilder optionsBuilder) { }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(
	        Assembly.GetExecutingAssembly());
    }

    public DbSet<Employee> Employees { get; set; }
    public DbSet<Registration> Registrations { get; set; }

    public async Task<bool> SaveAsync(
	CancellationToken cancellationToken = default(CancellationToken))
    {
	    // Dispatch domain events from mediatorExtensions class 
	    // to their respective event handlers
        await _mediator.DispatchDomainEventsAsync(this); 

        await base.SaveChangesAsync(cancellationToken);
        return true;
    }
}
```

7. Use new `SaveAsync` method instead of  `SaveChangesAsync` in repository.

##### API Layer

8. Make sure the necessary assemblies are added in `Program.cs`:
```cs
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblyContaining<GetEmployeesQuery>()); // for CQRS in Application Layer
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblyContaining<AggregateRoot>()); // for Domain Events in Domain Layer
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblyContaining<AppDbContext>()); // for Domain Events in Domain layer

```


---

## Logging

[Medium: Logging in ASP.NET Core 6 - Oguz Evrensel](https://medium.com/@oevrensel/logging-in-asp-net-core-17efca14d953)



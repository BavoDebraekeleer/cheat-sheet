# ASP .NET Core API

## Courses

- [Pluralsight Path: ASP.NET Core 6 Web API](https://app.pluralsight.com/paths/skills/aspnet-core-6-web-api)
- [Pluralsight: ASP.NET Core 6 Web API Fundamentals by Kevin Dockx](https://app.pluralsight.com/library/courses/asp-dot-net-core-6-web-api-fundamentals/table-of-contents)
- [Blog Post: Service Lifetimes in ASP.NET Core by Elisenda Gascon](https://endjin.com/blog/2022/09/service-lifetimes-in-aspnet-core)
- [Dependency Injection and Service Lifetimes in .NET Core by Henrique Siebert Domareski](https://henriquesd.medium.com/dependency-injection-and-service-lifetimes-in-net-core-ab9189349420)
- [Best Practices for Designing a Pragmatic RESTful API by Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api)
- [Microsoft Learn: Controller action return types in ASP.NET Core web API](https://learn.microsoft.com/en-us/aspnet/core/web-api/action-return-types?view=aspnetcore-7.0)

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

### HTTP Post – Create

### HTTP Put – Update
### HTTP Patch – Partial Update

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
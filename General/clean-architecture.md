# Clean Architecture

## Courses and Documentation

- [Pluralsight: Clean Architecture: Patterns, Practices, and Principles by Matthew Renze](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)
- [Clean Architecture with .NET and .NET Core — Overview by Ashish Patel](https://medium.com/dotnet-hub/clean-architecture-with-dotnet-and-dotnet-core-aspnetcore-overview-introduction-getting-started-ec922e53bb97#:~:text=User%20Interface%20(Web%2FApi),UI%2C%20API%2C%20etc.))
- [GitHub: Clean API Template by Edin Sahbaz](https://github.com/edinSahbaz/clean-api-template)

### Reading List

- [Patterns of Enterprise Application Architecture by Martin Fowler](https://www.bol.com/be/nl/f/patterns-of-enterprise-application-architecture/9200000002778071/)
- [Clean Architecture by Robert “Uncle Bob” Martin](https://www.bol.com/be/nl/f/clean-architecture/9200000051454864/)
- [Dependency Injection – Principles, Practices, and Patterns by Steven van Deursen and Mark Seemann](https://www.manning.com/books/dependency-injection-principles-practices-patterns)

### Websites

- Martin Fowler: http://martinfowler.com
- Greg Young: https://goodenoughsoftware.net 
- Udi Dahan: http://udidahan.com

---

## Introduction

Clean Architecture style focus on a loosely coupled implementation of use cases. Use cases as central organizing structure, decoupled from frameworks and technology details.

Good architecture is:
- Simple – meaning only as complex as it needs to be, and not accidental.
- Understandable – easy to grasp as a whole.
- Flexible – easy to adapt the system to changing requirements.
- Emergent – the architecture evolves over the life of the project.
- Testable – the architecture makes testing easier.
- Maintainable – all the above lead to an architecture that is more maintainable.

Clean architecture is designed for the inhabitants (users, developers, maintainers), not for the architect or the machine.
Focusing on the essentials, building what is necessary, when it is necessary. Avoiding premature optimization, while optimizing for maintainability.


![[Pasted image 20231016145835.png]]

![[Pasted image 20231016145806.png]]


---

## Overview

With Clean Architecture, the **Domain** and **Application** layers are at the center of the design which is known as the **Core** of the system. Business Logic places into these two layers, while they contain different kinds of business logic. They are seen as details and the business layers should not depend on Presentation and Infrastructure layers. Instead of having business logic depend on data access or other infrastructure concerns, this dependency is inverted: infrastructure and implementation details depend on the Application layer. This functionality is achieved by defining abstractions, or interfaces, in the Application layer, which are then implemented by types defined in the Infrastructure layer. A common way of visualizing this architecture is to use a series of concentric circles, similar to an onion architecture.

The **Domain** layer contains enterprise logic and types and the **Application** layer contains business logic and types. The difference is that enterprise logic could be shared across many systems, whereas the business logic will typically only be used within a system.

**Core** should not be dependent on data access and other infrastructure concerns so those dependencies are inverted. This is achieved by adding interfaces or abstractions within **Core** that are implemented by layers outside of **Core**.

All dependencies flow inwards and **Core** has no dependency on any other layer. **Infrastructure** and **Presentation** depend on **Core**, but not on one another.

![[Pasted image 20231017093548.png]]
![[Pasted image 20231017094550.png]]


---

## Domain-centric Architecture

![[Pasted image 20231016152804.png]]

Domain and Use Cases are essential. Wrapped in an Application layer.
Presentation and Persistence is a detail, pointing inwards towards the Domain.

![[Pasted image 20231016153456.png]]

BCE Architecture Pattern:
![[Pasted image 20231016153529.png]]

---

## Layered Architecture

Layers are the way an application is sliced into manageable units of complexity.
Designed to:
- represent different levels of abstraction,
- help with SRP,
- isolate developer roles and skills,
- help support multiple implementations,
- and assist with varying rates of change.


![[Pasted image 20231016161221.png]]
![[Pasted image 20231016161242.png]]

*Example:*
![[Pasted image 20231016161914.png]]
![[Pasted image 20231016171604.png]]

![[Pasted image 20231017094322.png]]

### Domain Layer

Domain Layer implements the core, use-case independent business logic of the domain/system. By design, this layer is highly abstracted and stable. This layer contains a considerable amount of domain entities and should not depend on external libraries and frameworks. Ideally it should be loosely coupled even to the .NET Framework.

Domain project is core and backbone project. It is the heart and center project of the Clean Architecture design. All other projects should be depended on the Domain project.

This package contains the high level modules which describe the Domain via Aggregate Roots, Entities and Value Objects.

Domain layer contains:

- Entities
- Aggregates
- Value Objects
- Domain Events
- Enums
- Constants

### Application Layer

Application Layer implements the use cases of the application based on the domain. A use case can be thought as a user interaction on the User Interface (UI). This layer contains all application logic. It is dependent on the domain layer, but has no dependencies on any other layer or project. This layer defines interfaces that are implemented by outside layers.

Application layer contains the application Use Cases which orchestrate the high level business rules. By design the orchestration will depend on abstractions of external services (e.g. Repositories). The package exposes Boundaries Interfaces (in other terms Contracts or Ports or Interfaces) which are used by the User Interface.

For example, if the application need to access a email service, a new interface would be added to application and an implementation would be created within infrastructure.

Application layer contains:

- Abstractions/Contracts/Interfaces
- Application Services/Handlers
- Commands and Queries
- Exceptions
- Models (DTOs)
- Mappers
- Validators
- Behaviors
- Specifications


### Infrastructure Layer

This layer is responsible to implement the Contracts (Interfaces/Adapters) defined within the application layer to the Secondary Actors. Infrastructure Layer supports other layer by implementing the abstractions and integrations to 3rd-party library and systems.

Infrastructure layer contains most of your application’s dependencies on external resources such as file systems, web services, third party APIs, and so on. The implementation of services should be based on interfaces defined within the application layer.

If you have a very large project with many dependencies, it may make sense to have multiple Infrastructure projects, but for most projects one Infrastructure project with folders works fine.

- Infrastructure.Persistence  
    - Infrastructure.Persistence.MySQL  
    - Infrastructure.Persistence.MongoDB
- Infrastructure.Identity

Infrastructure layer contains:

- Identity Services
- File Storage Services
- Queue Storage Services
- Message Bus Services
- Payment Services
- Third-party Services
- Notifications  
    - Email Service  
    - Sms Service


### Persistence Layer

This layer handles database concerns and other data access operations. By design the infrastructure depends on Application layer. This project contains implementations of the interfaces (e.g. Repositories) that defined in the Application project.

For instance an SQL Server Database is a secondary actor which is affected by the application use cases, all the implementation and dependencies required to consume the SQL Server is created on infrastructure (persistence) layer.

For example, if you wanted to implement the Repository pattern you would do so by adding an interface within Application layer and adding the implementation within Persistence (Infrastructure) layer.

Persistence layer contains:

- Data Context
- Repositories
- Data Seeding
- Data Migrations
- Caching (Distributed, In-Memory)


### Presentation / User Interface (Web/Api) Layer

This layer is also called as Presentation. Presentation Layer contains the UI elements (pages, components) of the application. It handles the presentation (UI, API, etc.) concerns. This layer is responsible for rendering the Graphical User Interface (GUI) to interact with the user or Json data to other systems. It is the application entry-point.

User Interface layer depends on both the Application and Infrastructure layers, however, the dependency on Infrastructure is only to support dependency injection. This layer can be an ASP.NET Core Web API with Single Page Application (SPA like Angular, React) or it can be an ASP.NET Core MVC with Razor Views.

This layer receives HTTP Requests from users, and Presenters converts the application outputs into ViewModels that are rendered as HTTP Responses.

User Interface layer contains:

- Controllers
- Views
- View Models
- Middlewares
- Filters/Attributes
- Web/API Utilities

---

## Project Structure

![[Pasted image 20231016151507.png]]

- Presentation – User Interface
- Application – Contains abstractions corresponding to the *use cases* of the application.
- Domain – Contains abstractions corresponding to the *problem / business domain*.
- Persistence – Interface providing access to the persistent data storage system, or database.
- Infrastructure – Interface for the OS and third party dependencies.
- Common – Contains cross cutting concerns, or dependencies where all other projects depend upon.
- Specification – Contains acceptance tests verifying the correct functionality of the application.


The following layer examples are from [GitHub: Clean API Template by Edin Sahbaz](https://github.com/edinSahbaz/clean-api-template).
### [Domain Layer](https://github.com/edinSahbaz/clean-api-template#domain-layer-1)

The Domain layer sits at the core of the Clean Architecture. Here we define things like entities, value objects, aggregates, domain events, exceptions, repository interfaces, etc.

Here is the folder structure used in this template: [![domain](https://user-images.githubusercontent.com/47791892/247073002-974e150d-d9c4-4ed1-967a-ab557092e019.png)](https://user-images.githubusercontent.com/47791892/247073002-974e150d-d9c4-4ed1-967a-ab557092e019.png)

You can introduce more things here if you think it's required.
One thing to note is that the Domain layer is not allowed to reference other projects in your solution.

### [Application Layer](https://github.com/edinSahbaz/clean-api-template#application-layer-1)

The Application layer sits right above the Domain layer. It acts as an orchestrator for the Domain layer, containing the most important use cases in your application.
You can structure your use cases using services or using commands and queries.
I'm a big fan of the CQRS pattern, so I like to use the command and query approach.

Here is the folder structure used in this template: [![application](https://user-images.githubusercontent.com/47791892/247073370-7c4d102f-5b00-442b-b710-a8af6f2a4402.png)](https://user-images.githubusercontent.com/47791892/247073370-7c4d102f-5b00-442b-b710-a8af6f2a4402.png)

In the Abstractions folder, we define the interfaces required for the Application layer. The implementations for these interfaces are in one of the upper layers.
For every entity in the Domain layer, we create one folder with the commands, queries, and events definitions.

### [Infrastructure Layer](https://github.com/edinSahbaz/clean-api-template#infrastructure-layer-1)

The Infrastructure layer contains implementations for external-facing services.
What would fall into this category?

- Databases - PostgreSQL, MongoDB
- Identity providers - Auth0, Keycloak
- Emails providers
- Storage services - AWS S3, Azure Blob Storage
- Message queues - Rabbit MQ

Here is the folder structure used in this template: [![infra](https://user-images.githubusercontent.com/47791892/247073402-db57066b-91ea-4560-8295-aa945d59fea6.png)](https://user-images.githubusercontent.com/47791892/247073402-db57066b-91ea-4560-8295-aa945d59fea6.png)

This project contains an implementation of DbContext if you use EF Core.
It's not uncommon to make the Persistence folder its project. I do this to have all database facing-code inside of one project.

### [Presentation Layer](https://github.com/edinSahbaz/clean-api-template#presentation-layer-1)

The Presentation layer is the entry point to our system. Typically, you would implement this as a Web API project.
The most important part of the Presentation layer is the Controllers(Endpoints), which define the API endpoints in our system.

Here is the folder structure used in this template: [![pres](https://user-images.githubusercontent.com/47791892/247074183-796222c9-e092-48ea-b263-a2cb80edfde2.png)](https://user-images.githubusercontent.com/47791892/247074183-796222c9-e092-48ea-b263-a2cb80edfde2.png)

In this case, we moved the Presentation layer away from the actual Web API project. We do this to isolate the Controllers and enforce stricter constraints.

---

## Commands & Queries

- Command:
	- Does something
	- Should modify state
	- Should not return a value
- Query:
	- Answers a question
	- Should not modify state
	- Should return a value

Maintain Command-Query Separation as much as possible!
To avoid side effects hidden in methods that do both.

Examples where it is not possible:
![[Pasted image 20231016172144.png]]

### CQRS Architecture

![[Pasted image 20231016172221.png]]

![[Pasted image 20231016172501.png]]

![[Pasted image 20231016172611.png]]

![[Pasted image 20231016172721.png]]
![[Pasted image 20231016172848.png]]

---

## Functional Organization

### Screaming Architecture

> The architecture should scream the intent of the system! *by Uncle Bob*

![[Pasted image 20231016192758.png]]
*Left: MVC folder structure, Right: structured by its high-level use cases*

![[Pasted image 20231016193409.png]]
![[Pasted image 20231016193656.png]]
![[Pasted image 20231016193631.png]]

---

## Microservices

![[Pasted image 20231016194437.png]]

![[Pasted image 20231016194512.png]]

![[Pasted image 20231016194529.png]]

![[Pasted image 20231016194637.png]]
![[Pasted image 20231016194752.png]]
![[Pasted image 20231016195050.png]]
![[Pasted image 20231016195409.png]]

---

## Evolving the Architecture

Have an architecture that can evolve over time.

![[Pasted image 20231016203642.png]]

![[Pasted image 20231016203746.png]]





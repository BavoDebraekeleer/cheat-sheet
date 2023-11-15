# Domain-Driven Design (DDD)

## QA

- Give an example of a Domain:
	A soft drinks factory, a hairdresser, a print shop, or a Vetrinary Clinic.

- What is Ubiquitous Language?
	Terminology decided on by both developers and domain experts to use when discussing anything concerning the domain model.

- What is an Aggregate Root?
	It is the base object of an aggregate set of object. If it it changes or deleted, these should be applicable to the complete aggregate.
    
- What is the difference between an Entity and a Value Object?
	An Entity is identified by a key ID with mutable properties.
	A Value Object is defined by the value of its properties and is immutable - meaning it can't change without becoming a new instance.
    
- Make a Domain schematic for the Timesheet assignment:

## Courses and Documentation

- [Pluralsight: Domain-Driven Design Fundamentals by Steve Smith and Julie Lerman](https://app.pluralsight.com/library/courses/fundamentals-domain-driven-design/table-of-contents)
- [Medium Post: Understanding Domain Objects, Entities, DTOs, and Models in C# by Abhinn Mishra](https://medium.com/@mishraabhinn/understanding-domain-objects-entities-dtos-and-models-in-c-207bb5c1d97c)

---

## Introduction

>Domain-Driven Design is an approach to software development that centres the development on programming a domain model that has a rich understanding of the processes and rules of a domain. — *Martin Fowler*

![[Pasted image 20231024100134.png]]

It is about really understanding the problem the client is having, and solving it with code, by interaction with *domain experts*.

>You really need to cultivate tour ability to communicate with business people to free up people's creative modelling. — *Eric Evans*

>While DDD provides many technical benefits, such as maintainability, it should be applied **only to complex domains** where the model and the linguistic processes **provide clear benefits** in the **communication of complex information**, and in the formulation of a **common understanding of the domain**. — *Eric Evans*

![[Pasted image 20231024101826.png]]

![[Pasted image 20231024101930.png]]

### Subdomains

Model a *single subdomain* at a time. Each having their own:
- tasks,
- ubiquitous language,
- unique problems.

![[Pasted image 20231024101058.png]]

*Separation of Concerns* plays an important role in implementing subdomains.

### DDD Mind Map

![[Pasted image 20231024102248.png]]

![[Pasted image 20231024102351.png]]

![[Pasted image 20231024102427.png]]

![[Pasted image 20231024102515.png]]

![[Pasted image 20231024102452.png]]

### Key Takeaways

- Solving problems, not just coding.
- Collaborate with domain experts.
- Break domain into smaller units.
- Efficient and effective path to success.
- Teamwork!

---

## Terminology

### Core Domain

The key differentiator for the customer's business. Something they must do well and cannot outsource.

### Subdomains

Separate applications or features your software must support or interact with.

### Bounded Contexts

A specific responsibility, with explicit boundaries that separate it from other parts of the system.

![[Pasted image 20231024112949.png]]

Defines where a Domain Model is valid.
The same type might be used in multiple contexts with different needs, and need to be separated.

>Explicitly define the context within which a model applies. Keep the model strictly consistent within these bounds, but don't be distracted or confused by issues outside it. — *Eric Evans*

Ideally, each different bounded context has its own separate team and databases.
But can also be done by separation through namespaces, folders, and projects.

![[Pasted image 20231024110738.png]]

In code, namespaces are helpful to quickly identify which bounded context you're working in.

Example:
![[Pasted image 20231024111850.png]]
![[Pasted image 20231024112522.png]]

##### Separate Database Problem

![[Pasted image 20231024115747.png]]

![[Pasted image 20231024115806.png]]

### Ubiquitous Language

The language using terms from a domain model that programmers and domain experts use to discuss that particular sub-system.

![[Pasted image 20231024102452.png]]

Come up and decide *terms* to be used when discussing a specific subdomain. These are terms that come from the *problem space*, not the *software space*.

This allows the customer / domain experts and developers to understand one another without confusion, and without the need to *translate* terminology.

Ubiquitous means it needs to be used everywhere within the bounded context. In conversations, discussions, diagrams, models, white boards, code, etc.

Don't make assumptions.

### Context Mapping

The process of identifying bounded contexts and their relationship to one another.

### Shared Kernel

Part of the model that is shared by two or more teams, who agree not to change it without collaboration, e.g. authentication.

### Context Map

Demonstrates how bounded contexts connect to one another while supporting communication between teams.

Example, Client points to the same person, while Notification is different for both contexts.
![[Pasted image 20231024115407.png]]

Ideally, everything is separate:
![[Pasted image 20231024115451.png]]

Realistically, some things are shared:
![[Pasted image 20231024115618.png]]

### Invariant

A condition that should always be true for the system to be in a consistent state.

![[Pasted image 20231025110722.png]]

### Associations

The modelled relationship between entities.

#### Navigation Properties

An ORM term to describe properties that reference related objects.

#### Unidirectional Relationships

Associations between two entities that can only be navigated in one direction.

### Predicate

Expression used in the search condition of a query's *where* clause.

Example (not SOLID):
![[Pasted image 20231025120334.png]]


### Generic Domain

The generic domain does not require any domain knowledge or analysis, and you can use existing solutions, frameworks, or libraries to implement it. The generic domain should be isolated from your core and supporting domains, and should be optimized for cost and maintenance.

3rd party tools:
- RabbitMQ
- Papercut


---
## Modelling

![[Pasted image 20231024101139.png]]

Steps:
1. Conversation with a Domain Expert
2. First Modelling Pass
3. Ubiquitous Language
4. Defining the Objects
5. Identifying Aggregates
6. Define Persistence needs in Repositories
7. Write Specification rules
8. Identify Domain Events
9. Consider the UI

Beware of Analysis Paralysis and the Falacy of Perfectionism.

> There's something about DDD that brings out the perfectionist in people. They say: "This model is not really good enough", and churn and churn.
> I'm here to say: "No model is going to be perfect".

The models don't need to be perfect. They only need to help us build the software that helps people solve problems and get their work done. So aim to develop a useful one.

### 1. Conversation with a Domain Expert

- Understand the client's business: talk to the domain experts at the start and throughout the project.
- Identify processes beyond the project's scope.
- Look for subdomains we should include, and ones we can remove from the scope.
- Don't make assumptions.

Example of a Veterinary Clinic, initial conversation:
![[Pasted image 20231024105506.png]]
![[Pasted image 20231024105559.png]]

Scheduling Subdomain, second conversation:
![[Pasted image 20231024110007.png]]
![[Pasted image 20231024110211.png]]


![[Pasted image 20231024110354.png]]

### 2. First Modelling Pass

Example Model:
![[Pasted image 20231024110532.png]]

Bounded Contexts for Client:
![[Pasted image 20231024111850.png]]
![[Pasted image 20231024112522.png]]
![[Pasted image 20231024120116.png]]

The Bounded Contexts can be split up into separate applications and/or microservices, but these don't necessarily correlate.

### 3. Ubiquitous Language

Define the Ubiquitous Language terminology with the Domain Experts.
Update the models accordingly.

Example:
![[Pasted image 20231024121332.png]]

### 4. Defining the Objects

Steps:
1. Is this a Value Object?
2. Otherwise, it's an Entity

![[Pasted image 20231025102236.png]]

![[Pasted image 20231025102314.png]]

### 5. Identifying Aggregates

1. Break the model up into aggregates.
2. Identify the roots.

*See Aggregates.*

### 6. Define Persistence needs in Repositories

*See Repositories.*

### 7. Write Specification rules

*See Specifications.*


### 8. Identify Domain Events

Phrases to look out for that point to an event:
- When this happens, then something else should happen.
- If that happens ...
- Notify the user when ...
- Inform the user if ...

Create events as needed, using the YAGNI principle – You Ain't Gonna Need It.
Meaning, only create an event if you require behaviour to occur that is decoupled from its trigger. So only if the behaviour does not belong in the class that is triggering it.

Consider the order of operations.
For example, persistence should succeed before notifications are sent.

Be careful not to design around failures with this pattern. Your Events and Handlers should never fail, so never make their behaviour dependent on exception throws.


### 9. Consider the UI

User Interface sketching can help visualize the important parts and functionality of the app.


---

## Domain Model

![[Pasted image 20231024122512.png]]

### Domain Layer

The Domain Layer is responsible for representing concepts of the business, information about the business situation, and business rules.
State that reflects the business situation is controlled and used here, even though the technical details of storing it is delegated to the infrastructure.
*This layer, the domain, is the heart of business software.*

Focus on *behaviours*, not attributes (changing the state of objects).

Example:
![[Pasted image 20231024143041.png]]

![[Pasted image 20231024143154.png]]

### Domain Model Types

- Anaemic – focussed on the state of its objects.
- Rich – represent the behaviour and business logic of the domain.

Strive for Rich Domain Models, but be aware of the strengths and weaknesses of those that are not so rich.

#### Anaemic

Anaemic is a Domain Model type that is focussed on the state of its objects.
It is considered an antipattern, because it only affects state, which is fine for a CRUD model, but not what you want in a DDD Model. It is contrary to the basic idea of object-oriented design, which is to combine data and process together.

![[Pasted image 20231024143659.png]]

#### Rich

Rich Domain Models represent the behaviour and business logic of the domain. It is what we aim for in modelling the domain.

---
## Types of Objects in DDD

- Entities – defined by an identity (key).
- Value Objects – defined by its value.

![[Pasted image 20231024144508.png]]

>We should strive to model using Value Objects instead of Entities wherever possible. Even when a domain concept must be modelled as an Entity, the Entity's design should be biased toward serving as a value container rather than a child Entity container. — *Vaughn Vernon*

While modelling:
1. Is this a Value Object?
2. Otherwise, it's an Entity


Other concepts are also technically objects (classes) in a system, but not real world objects.

- (Domain) Services
- Aggregates
- Repositories
- Domain Events

![[Pasted image 20231025151317.png]]


### Entities

Entities have a key as identifier, because they are mutable – their properties may change.

![[Pasted image 20231024150112.png]]

>Single Responsibility is a good principle to apply to entities. It points you toward the sort of responsibility that an entity should retain. Anything that doesn't fall in that category, we ought to put somewhere else. — *Eric Evans*

Example:
![[Pasted image 20231024144821.png]]
![[Pasted image 20231024144922.png]]
![[Pasted image 20231024145135.png]]

#### GUIDs or INT IDs

Use GUIDs instead of relying on the database to provide the ID's. Makes testing easier, because you don't depend on a database. But database performance favours integers for keys.
You can also use both!

![[Pasted image 20231024145606.png]]

#### EF vs DDD Entities

In Entity Framework Core:
A data model class with a key that is mapped to a table in a database.

In Domain-Driven Design:
A domain class with an identity for tracking.

![[Pasted image 20231024142352.png]]

---

### Value Objects

Defined by their values.

Attributes:
- Measures, quantifies, or describes a thing in the domain.
- Identity is based on the composition of values.
- Immutable (values never change).
- Compared by comparing all values.
- May have methods and behaviour, but never with side effects. Methods should only compute things, never change the state of the value object or system. (If a value needs to change, a new value object should be returned.)

![[Pasted image 20231025094126.png]]

Examples:
- String – an immutable collection of characters. If one character changes, the meaning of the word(s) change. Methods that change a string, like `.ToUpper()`, don't mutate the instance you pass to it, but return a new instance.
- Money – only has meaning with both a currency and the amount combined. ![[Pasted image 20231025095616.png]]

- Dates ![[Pasted image 20231025095731.png]]

- IDs – having custom Value Objects for IDs helps to avoid errors in passes parameters. *For example, if you need to pass two IDs of a different type to a method, if they're both int's or GUIDs, they can easily be put in the wrong order. If they instead have a specific Value Object type per ID, they can't be interchanged.*

>Value Objects are a perfect place to put methods and logic, because we can do our reasoning without side effects and identity. All those things that make logic tricky. We can put functions on those Value Objects, and do the pure reasoning there. — *Eric Evans*

General rules:
- The state of a Value Object should not be changed once it has been created.
- Value objects should get all of their states through their constructor.
- Any value checks should happen in the constructor as well.

*Example:*
```c#
public class DateTimeRange : ValueObject 
{
	public DateTime Start { get; private set; } 
	public DateTime End { get; private set; } 

	public DateTimeRange (DateTime start, DateTime end) 
	{ 
		// Ardalis.GuardClauses supports extensions with custom guards.
		Guard.Against.OutOfRange(start, nameof(start), start, end); 
		Start = start; End = end; 
	} 
	
	public DateTimeRange (DateTime start, TimeSpan duration) 
		: this(start, start.Add(duration)) { } 
		
	public DateTimeRange NewEnd (DateTime newEnd) 
	{ 
		return new DateTimeRange(this. Start, newEnd); 
	}
	
	public bool Overlaps (DateTimeRange dateTimeRange) 
	{ 
		return this.Start dateTimeRange. End && this.End >dateTimeRange.Start; 
	}
		
	// Used by base ValueObject type to implement equality.
	protected override IEnumerable<object> GetEqualityComponents() 
	{
		yield return Start; 
		yield return End;
	}
}
```

![[Pasted image 20231025102204.png]]

---
## Domain Services

Services are often orchestrators for operations that require several collaborating Entities and Value Objects.

![[Pasted image 20231025102528.png]]

Rules:
- Not a natural part of en Entity or Value Object, otherwise the logic should be put there.
- Has an interface that's comprised of domain model elements.
- Stateless, but may have side effects – should always be able to do the same operations with a new instance, instead of relying on any previous history of another instance.
- Lives in the core of the application.

![[Pasted image 20231025103159.png]]

---

## Aggregates

An Aggregate is a cluster of associated objects that we treat as a unit for the purpose of data changes. A transactional graph of objects.

![[Pasted image 20231025103650.png]]

Rules:
- Aggregates should enforce data consistency to ensure a valid object.
- Data changes should follow ACID – Atomic, Consistent, Isolated, and Durable.

### Associations (Relationships)

The modeled relationships between entities.

Rules:
- Try to avoid Bi-Directional relations, if it isn't strictly necessary in the bounded context.
- Aggregate Roots can depend on other roots, but never on the objects within an aggregate that is not the root.

Aggregate Roots keep instance references of the objects within the aggregate. Meaning, it keeps an instance of those objects. So if the root is deleted, the objects it keeps should be deleted as well.
If an object should simply point to another object, but not affect that object in any way, it can still be an Aggregate Root, but should simply hold a Foreign Key ID property of the object.

Single-Direction Example:
![[Pasted image 20231025104900.png]]
No need here to be able to go from Patient to Client, because a Patient shouldn't be able to change the Client, though a `ClientId` is kept to know to which Client the Patient belongs.

Object relationships are not the same as relationships between persisted data.

![[Pasted image 20231025105620.png]]

### Invariants

![[Pasted image 20231025110736.png]]

### Aggregate Root

The entry point of an aggregate, which ensures the integrity of the entire graph.

Aggregate Roots keep instance references of the objects within the aggregate. Meaning, it keeps an instance of those objects. 

Example:
![[Pasted image 20231025103919.png]]

To identify the Aggregate Root – if you delete the object, do all other objects in the Aggregate get deleted as well?

![[Pasted image 20231025104337.png]]


Checks to see if the Aggregate Root makes sense:
- Enforces invariants?
- Saving changes can save entire aggregate?
- Cascading delete is okay?

Example:
![[Pasted image 20231025111650.png]]
![[Pasted image 20231025111625.png]]


![[Pasted image 20231025112446.png]]

---

## Repositories (Repository Pattern)

A repository is an abstraction the domain model uses to define what persistence needs it has. It is a class that encapsulates the data persistence for an aggregate root.

Remember, a domain model should be persistence ignorant as well as ignorant of implementation details (the what) – applying Dependency Inversion and Interface Segregation.

![[Pasted image 20231025113736.png]]

Persistence Logic through Data Access is separated into Repositories to achieve Persistence Ignorance – Business objects have no logic related to how data is stored and retrieved.

![[Pasted image 20231025113947.png]]

Repository benefits:
- Provides common abstraction for persistence.
- Promotes separation of concerns.
- Communicates design decisions.
- Enables testability.
- Improved maintainability.

Typical methods:
- Add
- Update
- Remove
- Retrieve

Tips:
- Use repositories for aggregate roots only.
- Client focuses on model, repository on persistence.

Common problems:
- N+1 Query errors.
- Inappropriate use of eager or lazy loading.
- Fetching more data than required.

### Database Profiling

Profiling can surface many problems.
There are a lot of Database Profiling tools available, in Database IDEs, code-based, and 3rd party.


### Generic Repository

A repository implementation that takes any entity type.
With an extra marker interface, it can also be enforced to only take Aggregate Root entities.

Example:
![[Pasted image 20231025120954.png]]

With Marker Interface:
![[Pasted image 20231025121029.png]]

### CQRS

Command Query Responsibility Segregation:
- Reading are Queries
- Writing are Commands

*Query* repositories focus on *reading* data.
*Command* repositories focus on *writing* data.

---

## Specifications (Specification Pattern)

Specifying the State of an Object.

>Specifications mesh smoothly with Repositories, which are the building block mechanisms for providing query access to domain objects and encapsulating the interface to the database. — *Eric Evans*

The Specification Pattern is a method of encapsulating a business rule so that it can be passed to other methods which are responsible for applying it.

![[Pasted image 20231025123207.png]]

![[Pasted image 20231025122316.png]]

![[Pasted image 20231025122332.png]]

Benefits:
- Named Classes via Ubiquitous Language.
- Reusable.
- Separate persistence from Domain Model and UI.
- Keep business logic out of the Persistence Layer and database.
- Help entities and aggregates follow SRP.

![[Pasted image 20231025123038.png]]

---

## Domain Events

A class that captures the occurence of an event in a domain object.

Alert that some activity or state change occurred in the context.
Other domains can subscribe to these alerts and respond in a loosely coupled manner.

>Use a domain event to capture an occurrence of something that happened in the domain.
>— Vaughn Vernon

![[Pasted image 20231025150838.png]]

Characteristics:
- Represent the past.
- Typically immutable.
- Name comes from the Bounded Context's Ubiquitous Language.
- If fired as part of a command on a domain object, use the command name.
- Should be its own separate class.
	- Capture event-specific details in the event class.
	- Keep it lightweight
- No behaviour or side effects of their own. These are handled by Handlers called by the app.

Examples:
![[Pasted image 20231025152508.png]]

### UI Events vs. Domain Events

![[Pasted image 20231025151829.png]]

### Hollywood Principle

*“Don't call us, we'll call you!”*
We don't call the handlers, the app calls us.

![[Pasted image 20231025153542.png]]

![[Pasted image 20231025153642.png]]

### Workflow

1. Create interfaces (or base types) for Handler and Domain Event.
2. Define Events and associated Handlers.
3. Create handler(s) for each event. (An event can have multiple handlers.)
4. Register, or record, the events on the associated entity.

*Code example in a repository:*
```c#
foreach (var domainEvent in entity.Events.ToArray())
{
	await _mediator.Publish(domainEvent).ConfigureAwait(false);
}
```

Follow the flow of events, and focus on an event object's references.

---
## Mediator Pattern (with MediatR)

- [CQRS with MediatR with Shalin De Silva](https://medium.com/@shalinds/command-query-responsibility-segregation-pattern-with-mediatr-a908b53c33b2)
- [MediatR - Beyond the basics by Cristian Lopes](https://medium.com/@cristian_lopes/mediatr-beyond-the-basics-8ab90841a732)

#### What is CQRS ?

In traditional architecture the same data model is used for both read and write operations. By using **_CQRS —_ C**ommand and **Q**uery **R**esponsibility **S**egregation we can separate write operations (commands) and the read operations (queries) into separate models in an application.

**_MediatR_** is a [NuGet package](https://www.nuget.org/packages/MediatR) for .NET applications that helps to implement the Mediator pattern and MediatR can be used as a useful tool to implement CQRS in a .NET application.

MediatR pattern helps to reduce direct dependency between multiple objects and make them collaborative through MediatR.

![[Pasted image 20231025154743.png]]


---

## Anti-Corruption Layer

Functionality that insulates a Bounded Context from foreign systems or contexts, and translates into and from other system's models, handling the interactions.

>Even when the other system is well-designed, it is not on the same model as the client. And often the other system is not well-designed. — *Eric Evans*

![[Pasted image 20231025160733.png]]

![[Pasted image 20231025161051.png]]

Example:
![[Pasted image 20231025161242.png]]

---

## Message Queues

A tool for storing and retrieving messages, often used by applications to communicate with one another in a disconnected fashion.

Communicate between separate applications without coupling between them.

Most Cloud services have this built in.

3rd party solutins: RabbitMQ.

![[Pasted image 20231025162701.png]]

![[Pasted image 20231025162812.png]]

### Service Bus

Software responsible for managing how messages are routed between numerous applications and services.

Decouples the routing of the message.
Usually sits on top of a Message Que.

![[Pasted image 20231025163044.png]]


### Example

![[Pasted image 20231025164037.png]]


![[Pasted image 20231025164008.png]]
![[Pasted image 20231025164859.png]]


![[Pasted image 20231025163818.png]]
![[Pasted image 20231025163852.png]]

---

## Validation

[Microsoft Learn: Design validations in the domain model layer](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/domain-model-layer-validations)



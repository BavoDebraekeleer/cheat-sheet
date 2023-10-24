# Domain-Driven Design (DDD)

## QA

- Give an example of a Domain:
    
- What is Ubiquitous Language?
    
- What is an Aggregate Root?
    
- What is the difference between an Entity and a Value Object?
    
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

Realisticly, some things are shared:
![[Pasted image 20231024115618.png]]


---
## Modelling

![[Pasted image 20231024101139.png]]

Steps:
1. Conversation with a Domain Expert
2. First Modelling Pass
3. Ubiquitous Language
4. Update Models

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

### Types of Objects in DDD

- Entities – defined by an identity (key).
- Value Objects – defined by its value.

![[Pasted image 20231024144508.png]]

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





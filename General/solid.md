# SOLID Principles

## Courses

- [dotNET academy: SOLID](https://learn.dotnetacademy.be/unit/view/id:8143)
- [Pluralsight: SOLID Principles for C# Developers by Steve Smith](https://app.pluralsight.com/library/courses/csharp-solid-principles)
- [Blog Post: What Are The SOLID Principles? The Art Of Writing Clean And Maintainable Code in C# by Christian Schou](https://blog.christian-schou.dk/what-are-the-solid-principles/)

---

## Introduction

SOLID is an acronym that represents five principles to write good software architecture:
- S –  Single Responsibility Principle
- O –  Open/Closed Principle
- L –  Liskov Substitution Principle
- I – Interface Segregation Principle
- D – Dependency Inversion Principle

![[Pasted image 20230928154257.png]]

---

## Design Patterns

A design pattern is a default solution for common design problems.

History:
- Flow Based Design using Flow Charts to visualize the design.
- Structured Programming says a structured code should have a single start- and end-point, with in between a set of modules.
- Object-Oriented Programming divides the functionality into objects with relations such as composition, references, and inheritance. Resulting in reusable, better readable, and better maintainable code.
- SOLID principles, largely by Robert C. Martin (uncle Bob).
- Today, it is crucial to work Agile, in close cooperation with the customer, and with quick adaptability to market and business strategy changes.



---


## S – SRP – Single Responsibility Principle 🎯

**Single Responsibility Principle** (_SRP_) states that a `class` should have only one reason to change, meaning it should have only one responsibility or job.

A class should be able to use functionalities of other classes and be able to switch them out for others without having to know their inner workings. For example, if a class contains data it should be able to use different types of writing out that data, e.g. to a file, database, or Web API. So it doesn't implement the writing out itself, because that's another responsibility than having the data, but it can use other objects to do the writing, and change those out if needed.

*Coupling* means in what sense a class depends on, and knows the inner workings of other classes. The coupling should be *low*, meaning non-dependable on others.

Classes with a single responsibility have a *high Cohesion*, meaning everything in it has to do with the same functionality.

To achieve SRP, we need to *Encapsulate* functionality as much as possible.
*Encapsulation* means, to isolate functionality as much as possible.

We want *low coupling* and *high cohesion*.

Practical:
- Classes should have a limited number of instance variables.
- Class methods should manipulate one or more of these instance variables.

*SRP does bother if you mix implementation details into otherwise high level code.*
### Key Takeaways

- Practice pain driven development, meaning don't force using SOLID before you have written some code. Apply them when pain points begin to emerge.
- Each class should have a single responsibility, or reason to change.
- Strive for high cohesion and loose coupling.
- Keep classes small, focused, and testable.

---

## O – OCP – Open/Closed Principle 🔐

The Open/Closed Principle (_OCP_) tells us that our entities should be *open* for extension but *closed* for modification. This allows for new functionalities to be added without altering existing code.

For example, we have a *Shape* class that saves the type of the shape as a variable.
If we want to add another type of shape, however, we need to *modify* the `Area()` method to be able to add it.
```c#
public class Shape
{
    public string Type { get; set; }

    public double Area()
    {
        if (Type == "Rectangle")
        {
            // Calculate area of the rectangle
            // ...
        }
        else if (Type == "Circle")
        {
            // Calculate area of the circle
            // ...
        }
        // More else-if blocks for other shapes, e.g., Triangle, Square, etc.
        // This code needs modification whenever a new shape is added.
        // This violates OCP.
    }
}
```

A better solution that adheres to OCP is to us *Abstraction* by an abstract *Shape* class, and make a new inheriting class for each shape that adds its own version of the `Area()` method. This way, you can easily add new shapes without needing to modify any of the others.
```c#
public abstract class Shape
{
    public abstract double Area();
}

public class Rectangle : Shape
{
    public double Width { get; set; }
    public double Height { get; set; }

    public override double Area()
    {
        return Width * Height;
    }
}

public class Circle : Shape
{
    public double Radius { get; set; }

    public override double Area()
    {
        return Math.PI * Radius * Radius;
    }
}

// Adding a new shape (e.g., Triangle) without modifying existing code.
public class Triangle : Shape
{
    public double Base { get; set; }
    public double Height { get; set; }

    public override double Area()
    {
        return 0.5 * Base * Height;
    }
}
```

*Abstraction* can be achieved by using an `abstract class` or and interface.
They are both a sort of template for other classes.
An abstract class can implement basic functionality and variables all inheriting classes should have. While an interface describes the properties and methods, a class should have to implement the interface.

*For bugfixes, it is OK to modify existing code, this has nothing to do with OCP.*
### OCP Simple Factory Pattern

In a factory pattern, you create an object without exposing the creation logic. An interface can be used for creating an object, but lets the subclass decide which class to instantiate. Rather than defining each object manually, you can do it programmatically.
In short, a factory is an object that creates other objects without the use of a constructor.
#### [Reflection](https://stackify.com/what-is-c-reflection/)

Reflection provides objects of type `Type` that describe assemblies, modules, and types. You can use reflection to *dynamically create an instance of a type*, bind the type to an existing object, or get the type from an existing object and invoke its methods or access its fields and properties. If you are using attributes in your code, reflection enables you to access them.

Instead of having a switch or if statements chain to create new objects, like in this example:
```c#
class MovieFactory
{
    public Movie Create(int movieType, string movie_name)
    {
        Movie movie = null;
        if (movieType == 1)
        {
            movie = new RegularMovie(movie_name);
        }
        if (movieType == 2)
        {
            movie = new ChildrenMovie(movie_name);
        }
        if (movieType == 3)
        {
            movie = new NewReleaseMovie(movie_name);
        }
        return movie;
    }
}
```

We can use *reflection*, using the `Activator.CreateInstance(Type...)` method.
This way, we don't need to modify this method every time a new type class is added.
```c#
class MovieFactory
{
    public Movie Create(string type, string movie_name)
    {
        try
        {
            Movie m = (Movie)Activator.CreateInstance(
	            Type.GetType(
		            $"SOLID_Start.Movies.{type}"), 
		            new Object[] { movie_name });
            return m;
        }
        catch(Exception e)
        {
            return null;
        }
    }
}
```

### Key Takeaways

- First, solve the problem using simple and concrete code.
- Identify the kinds of changes the application is likely to continue needing. Avoid speculating without actual requirements.
- Refactor code to be extensible along the axis of change you've identified (from actual requirements). Without the need to modify its source each time.

---


## L – LSP – Liskov Substitution Principle  ![[Pasted image 20230927162016.png|20]]

The Liskov Substitution Principle (_LSP_) tells us that objects of a superclass or base class, should be replaceable with objects of its subclasses without affecting the correctness of the program.

The OOP relation *“IS-A”* should be replaced with *“IS-REPLACABLE-WITH / IS-SUBSTITUTABLE-FOR”*.

You shouldn't have to perform the following to adhere to LSP:
- *Type Checking*, for example with *is* or *as* in polymorphic code, including *null checks*.
- Get *Not Implemented Exceptions* with the use of *Interfaces*.

### Example Type Checking

With the following type checking example, using *is* and *as*, every time you add a subtype the code needs to change, violating OCP. This also violates LSP by having specific code per type, where subclasses have specific behavior that can't be substituted for their superclass. 
```c#
foreach (var employee in employees)
{
	if (employee is Manager)
	{
		Helpers.PrintManager(employee as Manager);
		break;
	}
	Helpers.PrintEmployee(employee);
}
```

A possible fix is to move the specific behavior out of the helper, and into an abstract method of the superclass that every subclass needs to implement its own override version of. Be careful not to violate SRP.
```c#
foreach (var employee in employees)
{
	employee.Print();
}
```

Another possible fix is to pass the objects as a superclass object to the helper, and implement the specific behavior in there. Though, this may only move the problem.
```c#
foreach (var employee in employees)
{
	Helpers.PrintEmployee(employee);
}
```

### Example `null` Checking and `null` Object Pattern

In the `MovieFactory` example we should return a `NullMovie` object instead of `null`. This is a subclass of `Movie`, which is the type that is excepted:
```c#
class NullMovie : Movie
{
    Logger logger;
    public NullMovie(string movie_name):base(movie_name)
    {
        logger = new Logger();
    }

    public override double RekeningVoor(int AantalDagen)
    {
        logger.Log("unknown movie type");
        return 0;
    }
}
```

```c#
class MovieFactory
{
    public Movie Create(string type, string movie_name)
    {
        try
        {
            Movie m = (Movie)Activator.CreateInstance(
	            Type.GetType(
		            $"SOLID_Start.Movies.{type}"), 
		            new Object[] { movie_name });
            return m;
        }
        catch(Exception e)
        {
            return new NullMovie("null movie");
        }
    }
}
```

### Detecting LSP Violations

Identify problems by looking for:
- Type checking
- `null` checking
- `NotImplementedException`

### Fixing LSP Violations

- Follow the *“Tell, Don't Ask” principle*: You shouldn't *ask* instances for their type and couple logic to it (e.g., `is` in `switch statement). Instead, encapsulate that logic into the type itself and *tell* it to perform it, no matter the type.
  ![[Pasted image 20230928092718.png]]
  
- Minimize null checks with:
	- C# features (e.g., `instance?.method()`)
	- Guard clauses
	- `null` Object Design Pattern


### Key Takeaways

- Subtypes must be substitutable for their base types.
- Ensure base type invariants are enforced. Make sure not to break them when implementing base types or interfaces.
- Identify problems by looking for:
	- Type checking
	- `null` checking
	- `NotImplementedException`


*LSP is keeping watch over your code!*

![[Pasted image 20230927162016.png|100]]


---


## I – ISP – Interface Segregation Principle 😰

The Interface Segregation Principle (_ISP_) tells us that our classes should not be forced to implement interfaces it does not use.

- Clients should not be forced to depend on methods they do not use.
- Prefer small, cohesive interfaces to large *fat* ones.
	- A *fat* interface includes requirements the client doesn't need, or not *all* clients need.
	- A *client,* in this context, is the code that is interacting with an instance of the interface. It's the calling code.

Large interfaces with lots of methods have:
- more coupling
- more brittle code, subject to possible bugs
- more difficult testing
- more difficult and riskier deployments

![[Pasted image 20230928102033.png]]

Example of a fat interface. It requires implementing methods that either the *DBLogger* or *FileLogger* don't need:
```c#
public interface ILog
{  
	void Log(string message);  
	 
	void OpenConnection();  
	void CloseConnection();  
}  

public class DBLogger : ILog  
{  
	public void Log(string message)  
	{  
		//Code to log data to a database  
	}  
	public void OpenConnection()  
	{  
		//Opens database connection  
	}  
	public void CloseConnection()  
	{  
		//Closes the database connection  
	}  
}  
public class FileLogger : ILog  
{  
	public void Log(string message)  
	{  
		//Code to log to a file             
	}  
	public void CloseConnection()  
	{  
		throw new NotImplementedException();  
	}  
	public void OpenConnection()  
	{  
		throw new NotImplementedException();  
	}  
}
```

The solution is encapsulating the specific methods to their own interfaces with inheriting from the base interface:
```c#
public interface ILog  
{  
	void Log(string message);       
}  
public interface IDBLog :ILog  
{  
	void OpenConnection();  
	void CloseConnection();  
}  
public interface IFileLog :ILog  
{  
	void CheckFileSize();  
	void GenerateFileName();  
}  

public class DBLogger : IDBLog  
{  
	public void Log(string message)  
	{  
		//Code to log data to a database  
	}  
	public void OpenConnection()  
	{  
		//Opens database connection  
	}  
	public void CloseConnection()  
	{  
		//Closes the database connection  
	}  
}  
public class FileLogger : IFileLog  
{  
	public void Log(string message)  
	{  
		//Code to log data to a database  
	}  
	public void CheckFileSize() { }  
	public void GenerateFileName() { }  
}
```

### Detecting ISP Violations

- Large interfaces.
- `NotImplementedException` in interfaces.
- Code uses just a small subset of a larger interface.

### Fixing ISP Violations

- Break up large interfaces into smaller ones. Then compose the fat interfaces from the smaller ones through inheritance for backward compatibility.
- To address large interfaces you don't control:
	- Create a small, cohesive interface.
	- Use the Adapter Design Pattern, so your code can work with the Adapter.
- Clients should own and define their interfaces.
	- Interfaces should be declared where both client code and implementations can access them.

### Adapter Design Pattern

The use of an abstract superclass to provide a base type, while the subclasses implement their own interfaces. This way, instances can be called by type.

*Example:*
```c#
interface IWorker
{  
	void Work();         
}  
interface IBreaker  
{  
	void Break();  
}  
interface IHumanWorker: IWorker, IBreaker  
{  
}  
  
abstract class Workable  
{  
	public abstract void DoWork();  
}  
class Werkmier : Workable, IHumanWorker  
{  
	void Break()  
	{  
		Console.WriteLine("i take a break");  
	}  
	public override void DoWork()  
	{  
		Work();  
		Console.WriteLine("...");  
		Break();  
	}  
	public  void Work()  
	{  
		Console.WriteLine("i work");  
	}  
 
}  
class Robot : Workable,  IWorker  
{  
	public override void DoWork()  
	{  
		Work();  
	}  
	public void Work()  
	{  
		Console.WriteLine("I Work non stop");  
	}  
}  

class Manager  
{  
	List<Workable> werkers;  
	public Manager()  
	{  
		werkers = new List<Workable>() {  
			   new Werkmier(),  
			   new Werkmier(),  
			   new Robot()  
		};  
	}  
	public void Start()  
	{  
		foreach (var worker in werkers)  
		{  
			worker.DoWork();  
		}  
	}  
}
```

### Key Takeaways

- Prefer small, cohesive interfaces to large, expansive ones.
- Following ISP helps with SRP and LSP.

### Learn More

- Microsoft Reference Application + e-book: github.com/dotnet-architecture/eShopOnWeb
- Clean Architecture Solution Template: github.com/ardalis/CleanArchitecture
- On Pluralsight:
	- [Domain-Driven Design Fundamentals by Steve Smith and Julie Lerman](https://app.pluralsight.com/library/courses/fundamentals-domain-driven-design/table-of-contents)
	- [Clean Architecture: Patterns, Practices, and Principles by Matthew Renze](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)

---


## D – DIP – Dependency Inversion Principle 🧱

The last principle, Dependency Inversion Principle (_DIP_), is responsible for making sure that high-level modules don't depend on low-level modules. In other words – This principle encourages us to rely on abstractions (interfaces or abstract classes) rather than concrete implementations. By doing so, we can decouple classes and make sure that the code is more maintainable and flexible.

Abstractions should not depend on details. Rather, details should depend on abstractions.

### Abstraction and Details, High- and Low-Level

***Abstractions***, like interfaces and abstract classes, is high-level code that describes ***what*** needs to happen, e.g., send a message, or store a customer record.

***Details*** is low-level code that specifies ***how*** it happens, e.g., send an SMTP email over port 25, or serialize customer to JSON and store in a text file.

High-level:
- More abstract
- Business rules
- Process-oriented
- Further from I/O

Low-level:
- Closer to I/O, close to *the metal*
- “Plumbing” code
- Interacts with specific external systems and hardware

The following example shows an interface – an abstraction – which is dependent on a concrete class – the details. This is a violation of DIP. 
```c#
public interface IOrderDataAccess
{
	SqlDataReader ListOrders(SqlParameterCollection params);
}
```

The details should be hidden, making the interfac independent of the *how*.
```c#
public interface IOrderDataAccess
{
	List<Order> ListOrders(Dictionary<string, string> params);
}
```

### New is Glue

Using `new` to create dependencies glues your code to that dependency.
`new` isn't bad, but be aware it creates coupling.
If you don't need a specific implementation, use an abstraction instead.

### Dependency Injection

***Dependency Injection*** is a technique to add dependencies to a class *when* the class requires it, but maintaining a *loose coupling*.

Dependencies are:
- References required to compile
- References required to run

Common dependencies:
- Third party library
- Database
- File system
- Web Service
- New keyword

The following example is a violation of DIP, because the *high level module* `Printer` is dependent on the concrete `EventLogWriter` class.
```c#
class EventLogWriter  
{  
    public void Write(string message)  
    {  
        //Write to event log here  
    }  
}

class Printer  
{  
    // Handle to EventLog writer to write to the logs.
    EventLogWriter writer = null;
    
    // This function will be called when the app pool has a problem.
    public void Notify(string message)  
    {  
        if (writer == null)  
        {  
            writer = new EventLogWriter(); // new keyword = dependency
        }  
        writer.Write(message);  
    }  
}
```

Three types of Dependency Injection:
- Constructor injection *(Preferred)*
- Method injection
- Property injection

#### Constructor Injection *(Preferred)*

An instance of the concrete class is passed to the dependent class via *the constructor*.
Use this injection type if the concrete class is used during the whole lifecycle of the dependent class.

The constructor of a class should contain all dependencies the class needs. These are called *explicit dependencies*. Otherwise, they are *hidden* dependencies.

It is the preferred injection type, because it:
- Follows the *Explicit Dependencies Principle*.
- Classes are never in an uninitialized state.
- Can leverage special factory types, called IOC or DI container, to construct types and their dependencies.

***Explicit Dependencies Principle***: dependencies listed in the constructor can't surprise clients.
Compare it to ingredients in a recipe. You want to know all ingredients beforehand by them being listed in the ingredient list. You don't want to find out about *new* ones later on in the recipe text.

An IOC (Inversion Of Control) container, is the same as a DI (Dependency Injection) container, or simply *services* container. This container is able to resolve the dependencies of your classes at runtime. ASP.NET Core has a built-in container. A third-party container is [Autofac](https://autofac.org/).


```c#
class Printer  
{  
	INotification writer;  
	public Printer(INotification logger)  
	{  
		writer = logger;  
	}  
	  
	public void Notify(string message)  
	{              
		writer.Notify(message);  
	}  
}
```

```c#
static void Main(string[] args)  
{  
	EventLogWriter log = new EventLogWriter();  
	Printer p = new Printer(log); // log instance injected in the constructor.
	p.Notify("dit is een test");  
	Console.ReadLine();  
}
```

#### Method Injection

An instance of the concrete class is passed to the dependent class via a *method call*.
Use this injection type if the dependent class uses multiple concrete classes for the same method.

```c#
class Printer  
{  
	INotification writer;  
	public Printer()  
	{  
	}  
	  
	public void Notify(INotification logger, string message)  
	{              
		logger.Notify(message);  
	}  
}
```

```c#
static void Main(string[] args)  
{  
	EventLogWriter log = new EventLogWriter();  
	Printer p = new Printer();  
	p.Notify(log,"dit is een test"); // log instance injected in a method.
	Console.ReadLine();  
}
```

#### Property Injection

An instance of the concrete class is passed to the dependent class via a *set property*.
Use this injection type if the concrete class should be swappable, without having to be passed to a method every time.

```c#
class Printer  
{  
	// Handle to EventLog writer to write to the logs.
	public INotification writer { get; set; }
	
	// This function will be called when the app pool has a problem.
	public void Notify(string message)  
	{  
		writer.Notify(message);  
	}  
}
```

```c#
 static void Main(string[] args)
 {  
	EventLogWriter log = new EventLogWriter();  
	Printer p = new Printer();  
	p.writer = log; // log instance is set to the property writer of the Printer.
	p.Notify("dit is een test");  
	Console.ReadLine();  
}
```

### Key Takeaways

- Most classes should depend on abstractions, not implementation details.
- Abstractions shouldn't leak details. They shouldn't care about how they are implemented.
- Classes should be explicit about their dependencies.
- Clients should inject dependencies when they create other classes.
- Use folders to structure your solution to leverage dependency inversion.


---

## Organizing and Extending

Give files very specific names of what they are.
Use folders to organize the files into groups.

Example folder structure:
- Core (business logic without dependencies)
	- Interfaces
	- Models
- Infrastructure (things with dependencies)
	- Loggers
	- Serializers
- User Interface

---



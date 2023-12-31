# Design Patterns

## Courses

- [dotNET academy: SOLID](https://learn.dotnetacademy.be/unit/view/id:8143)
- [YouTube: Change Behaviors with the Strategy Pattern - Unity and C# by One Wheel Studio](https://www.youtube.com/watch?v=yjZsAl13trk)
- [Pluralsight: Clean Architecture: Patterns, Practices, and Principles by Matthew Renze](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)
- [Article: Dependency Injection Pattern In C# - Short Tutorial by Mark Pelf](https://www.c-sharpcorner.com/article/dependency-injection-pattern-in-c-sharp-short-tutorial/)
- [Microsoft Learn: .NET dependency injection](https://learn.microsoft.com/en-us/dotnet/core/extensions/dependency-injection)
- [Article: Singleton Pattern in C# by Jallen Liao](https://medium.com/@lancelyao/singleton-pattern-in-c-b2bc4b1e0532)
- [Pluralsight: C# 10 Design Patterns - by Kevin Dockx](https://app.pluralsight.com/library/courses/c-sharp-10-design-patterns/table-of-contents)


---

## Introduction

A design pattern is a default and reusable solution for common design problems.
Should be viewed as a template to start from, not a rule.

History:
- Flow Based Design using Flow Charts to visualize the design.
- Structured Programming says a structured code should have a single start- and end-point, with in between a set of modules.
- Object-Oriented Programming divides the functionality into objects with relations such as composition, references, and inheritance. Resulting in reusable, better readable, and better maintainable code.
- SOLID principles, largely by Robert C. Martin (uncle Bob).
- Today, it is crucial to work Agile, in close cooperation with the customer, and with quick adaptability to market and business strategy changes.

### Difference between a Pattern and a Principle

A **_Software Design Pattern_** is called a *pattern* because it suggests *low-level specific* implementation to a specific issue.

A **_Software Design Principle_** is called *principle* because it provides *high-level advice* on how to design software products.

### Gang of Four

Group of developers that published a book on Design Patterns in 1994 that is still relevant today. They are:
- Erich Gamma
- Richard Helm
- Ralph Johnson
- John Vlissides

![[Pasted image 20231107103153.png]]

### Pattern Types

- Creational
- Structural
- Behavioural

#### Creational

Deal with object creation.
Help with making the system independent of how objects are created.

- Abstract Factory
- Builder
- Factory Method
- Prototype
- Singleton

#### Structural

Deal with ways to define relations between classes or objects.
Concerned with how classes and objects are composed to form a larger structure.

- Adapter
- Bridge
- Composite
- Decorator
- Facade
- Flyweight
- Proxy

#### Behavioural

Ways to communicate between classes or objects.
Characterize complex control flow that is difficult to follow at runtime.
Let you concentrate on the way objects are interconnected.

- Chain of Responsibility
- Command
- Interpreter
- Iterator
- Mediator
- Memento
- Observer
- State
- Strategy
- Template Method
- Visitor


---

## Factory Pattern

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
            return new NullMovie("null movie"); // Applying LSP
        }
    }
}
```

---

## Adapter Design Pattern

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

---

## Strategy Pattern

Strategy is **a behavioural design pattern that turns a set of behaviours into objects and makes them interchangeable inside the original context object**. The original object, called context, holds a reference to a strategy object. The context delegates executing the behaviour to the linked strategy object.

In scenarios where you would have to change an object type, you would normally have to instantiate a new object of that different type and by doing so lose all possible data it holds.
By identifying what the reason is why you would have to change type, and encapsulating this into a strategy object, you now no longer have to change object type, but just switch out the strategy object.

*Adheres to OCP, or Open/Closed Principle, because you can add functionality without modifying existing code.*

![[Pasted image 20230929111556.png]]

### Movie Rental Example (using abstract classes)

#### Without Strategy Pattern

There are three subclasses of the abstract base class `Movie`.The only thing the subclasses implement is the `GetCharge` method, which basically returns the pricing. If, over time, we want to change the `Movie` type from `NewReleaseMovie` to `RegularMovie` we would have to instantiate a new object to only change the pricing, while losing all other data, in this case the title.

![[Pasted image 20230929101415.png]]

```c#
public abstract class Movie   
{   
	private string _title;   

	public Movie(string title)    
	{   
		_title = title;   
	}   

	public string GetTitle()   
	{   
		return _title;   
	}   

	public abstract double GetCharge(int daysRented);
}
```

```c#
class NewReleaseMovie : Movie   
{   
	public NewReleaseMovie(string title) : base(title) { }   
	   
	public override double GetCharge(int daysRented)   
	{   
		return  daysRented * 3;   
	}   
}
```

#### With Strategy Pattern

By applying the Strategy Pattern, we identified why we would have to change the object type, being the pricing, so introduced the `Price` strategy object as a property of `Movie`.
This way, when a `Movie` object changes from `NewRelease..` to `Regular..`, only the `Price` property has to change from `NewReleasePrice` to `RegularPrice`, while the `Movie` object and all its other data, like title, are kept.

![[Pasted image 20230929101431.png]]

```c#
public class Movie
{
    public string Title { get; set; }
    public Price PriceType { get; set; }

    public Movie(string title)
    {
        this.Title = title;
    }

    public double getCharge(int daysRented)
    {
        return this.PriceType.getCharge(daysRented);
    }
}
```

```c#
public abstract class Price   
{   
	public abstract double getCharge(int daysRented);
	// abstract, so subclasses HAVE TO provide their own implementation.

	public virtual int getFrequentRenterPoints(int daysRented)
	// virtual, so subclasses CAN provvide their own implementation.
	{   
		return 1;   
	}   
}
```

```c#
class RegularPrice : Price   
{   
	public override double getCharge(int daysRented)   
	{   
		double result = 2;   
		if (daysRented > 3)   
			result += (daysRented - 2) * 1.5;   

		return result;   
	}   
}
```

```c#
public class NewReleasePrice : Price   
{   
	public override double getCharge(int daysRented)   
	{   
		return daysRented * 3;   
	}   

	public override int getFrequentRenterPoints(int daysRented)   
	{   
		return (daysRented > 1) ? 2 : 1;   
	}   
}
```

```c#
class PriceFactory // Applying OCP = Open/Closed Principle
{
    public Price Create(string type)
    {
        try
        {
            Price p = (PrijsT)Activator.CreateInstance(
	            Type.GetType($"SolutionName.FolderName.{type}Price"), 
	            new Object[] { });
            return p;
        }
        catch (Exception e)
        {
	        // Applying LSP = Liskov Substituation Principle
            return new NullPrice("null price");
        }
    }
}
```

### Unity Game Example (using an interface)

Using an interface.

Instead of implementing the `DoDamage` method in the base class, it is moved to an interface `IDoDamage`. This interface is then used as a property in the base class, so subclasses can set the `damageType` in their constructor. This way, the `TryDoAttack` method only needs to be implemented once in the base class, and no modifications, or overrides in the subclasses are necessary. 
The different types of damage are separate classes that implement the `IDoDamage` interface.
The `?` `null` check in `TryDoAttack` also allows for weapons that don't do any damage.

![[Pasted image 20230928163436.png]]

New types of damage can easily be added, without having to modify the base class or the `TryDoAttack` method. The damage type can also easily be interchanged, for example, to allow for modifiers which change the damage type of a weapon.

![[Pasted image 20230928163732.png]]

Instead of making separate subclasses for different damage types, you can also make a more generic subclass that gets the damage type as a constructor parameter, instead of hard coded.

![[Pasted image 20230928163758.png]]

If you want the ability to add multiple damage types per weapon, you can make the property into a list. Where you then step through.

![[Pasted image 20230929093323.png]]

*Note: the base class inherits from `MonoBehaviour`, because this is a Unity example, and this makes it easier to attach to a button in Unity.*


### Happy Hour Billing Example (using an interface)

![[Pasted image 20230929111240.png]]

![[Pasted image 20230929111335.png]]

![[Pasted image 20230929111359.png]]


---

## Dependency Injection Pattern

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

The main problem this pattern aims to solve is how to create “loosely coupled” components. It does that by separating the creation of components from their dependencies.

There are four main roles (classes) in this pattern:
1. **Client.** The client is a component/class that wants to use services provided by another component, called a Service.
2. **Service-Interface.** The service interface is an abstraction describing what kind of services the Service component is providing.
3. **Service.** The Service component/class is providing services according to Service-Interface description.
4. **Injector.** Is a component/class that is tasked with creating Client and Service components and assembling them together.

The way it works is that the Client is dependent on Service-Interface IService. The client depends on the IService interface, but has no dependency on the Service itself. Service implements the IService interface and offers certain services that the Client needs. Injector creates both Client and Service objects and assembles them together. We say that Injector “injects” Service into Client.

Class Diagram:
![[Pasted image 20231005085829.png]]

```c#
public interface IService {
    void UsefulMethod();
}
public class Service: IService {
    void IService.UsefulMethod() {
        //some usefull work
        Console.WriteLine("Service-UsefulMethod");
    }
}
public class Client {
    public Client(IService injectedService = null) {
        //Constructor Injection
        _iService1 = injectedService;
    }
    private IService _iService1 = null;
    public void UseService() {
        _iService1?.UsefulMethod();
    }
}
public class Injector {
    public Client ResolveClient() {
        Service s = new Service();
        Client c = new Client(s);
        return c;
    }
}
internal class Program {
    static void Main(string[] args) {
        Injector injector = new Injector();
        Client cli = injector.ResolveClient();
        cli.UseService();
        Console.ReadLine();
    }
}
```

Three types of Dependency Injection:
- Constructor injection *(Preferred)*
- Method injection
- Property injection

#### Example Case

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

### Constructor Injection *(Preferred)*

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

### Method Injection

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

### Property Injection

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


---

## Inversion of control – IoC




---

## Singleton Pattern

The purpose of Singleton Pattern is to create only one common access to an object, which means the class can only have on instantiation.

Singleton: Single instance shared across the application.

A singleton object is created only once during the lifetime of an application, and the same instance is shared by all components that require it. Subsequent requests for the object will return the same instance. This pattern is useful for objects that should have a global and shared state across the application.

_Example: Let’s say you have a logging service that needs to be accessed by multiple components in your application. By registering the logging service as a singleton, all components will share the same instance, ensuring consistent logging behavior across the application._

*Singleton Pattern Diagram:*
![](https://miro.medium.com/v2/resize:fit:382/1*546cgD2MFxHPKib3FFAZGw.png)

![[Pasted image 20231107105512.png]]

If managed by an IOC Container it no longer violates SRP because the instance doesn't manage the instance creation, but the container does.

### Why WOULD you use a Singleton?

[Singleton Design Pattern in C# by Scott Lilly](https://scottlilly.com/c-design-patterns-the-singleton-pattern/)

You might want to use the singleton pattern for classes that use an external resource, and there might be problems if multiple objects try to use that resource at the same time. For example, the file system, a database server, a web service, etc.

If your program needs to do logging, you may want all output to be written to one log file. That could lead to resource conflicts and errors.

![Without a singleton, each business object has its own logging object.](https://www.scottlilly.com/wp-content/uploads/2016/05/WithoutSingleton.png)

With a singleton logger object, you don’t need to worry about several different objects trying to write to the same file, at the same time.

![With a singleton, the business objects share a single logging object](https://www.scottlilly.com/wp-content/uploads/2016/05/WithSingleton.png)


### Why WOULDN'T you use a Singleton?

Another option is to use a global, or static, class. But that usually leads to bad programming practices. After a while, those classes tend to hold a lot of unrelated information and objects.

This can still happen with singletons, which is why some programmers say singletons are an “*anti*-pattern” – a bad programming practice.

There are times when singletons can be useful. However, like many programming decisions, you need to consider the positives and negatives.

Plus, you can more easily create “mock” versions of your singleton class, for unit testing. This is difficult to do with static classes.


### Implementation

The **singleton [design pattern](https://www.educative.io/edpresso/design-patterns-in-java)** is used to restrict a class to only one instance at a time. This restriction is achieved by changing the accessibility of the constructor to `private` so that a new instance cannot be created using that constructor from outside the class. The **[static](https://www.educative.io/edpresso/how-to-use-static-keyword-in-java) method** **`GetInstance()`** (defined in the class) creates a new instance after checking if an instance already exists. If it does, the same instance is returned; otherwise, a new instance is created and returned. The **static variable** **`instance`** keeps track of the existing instance of the class.

#### Static Initializer Singleton Pattern (C# Only!)

Guarantees an instance gets created and multi-thread safe.

Pattern:
```c#
class ClassName
{ 
	private static readonly ClassName _instance = new ClassName();
	
	private ClassName() { } // private Constructor
		
	public static ClassName GetInstance() // public static method
	{
		return _instance; 
	}
}; 
```

#### Multi-Thread Safe Method

Pattern:
```c#
class ClassName
{ 
	private static ClassName _instance; // private static field
	private static readonly object _syncLock = new object();
	// _syncLock is just an object for the lock to hold on too, nothing special.
	
	private ClassName() { } // private Constructor
		
	public static ClassName GetInstance() // public static method
	{
		if (_instance == null) // Check if an instance already exists
		{
			lock(_syncLock) // The first thread call gets a lock on next code
			{
				_instance ??= new ConsoleMessengerSingleton();
			}
		}
		return _instance; 
	}
}; 
```

#### NOT Multi-Thread Safe Method

Pattern:
```c#
class ClassName
{ 
	private static ClassName _instance; // private static field
	
	private ClassName() { } // private Constructor
		
	public static ClassName GetInstance() // public static method
	{
		if (_instance == null) // Check if an instance already exists
		{
			_instance = new ClassName(); // Create a new instance
		}
		return _instance; 
	}
}; 
```

Shorter version:
```c#
class ClassName
{ 
	private static ClassName _instance; // private static field
	
	private ClassName() { } // private Constructor
		
	public static ClassName GetInstance() // public static method
	{
		return _instance ??= new ConsoleMessengerSingleton();
	}
}; 
```

*Example:*
```c#
#include <iostream> 

using namespace std; 

class Singleton
{ 
	private static Singleton* _instance; // private static field
	
	private Singleton() // private Constructor
	{ 
		cout << "New instance created!" << endl; 
	} 
		
	public static Singleton* GetInstance() // public static method
	{
		// Check if an instance already exists: 
		if (_instance == nullptr)
		{
			_instance = new Singleton(); // Create a new instance
		}
		return _instance; 
	} 
}; 

Singleton* Singleton::instance = nullptr; 

int main()
{ 
	// Private default constructor can't be accessed: 
	// Singleton* s = new Singleton(); 
	
	Singleton* s = Singleton::getInstance(); 
	Singleton* t = Singleton::getInstance(); 
	
	// Print address of where 's' and 't' point 
	// to make sure that it is the same object: 
	cout << "'s' points to: " << s << endl 
	<< "'t' points to: " << t << endl; 
	
	return 0; 
}
```


---

## Railway Oriented Programming

[Railway Oriented Programming : A powerful Functional Programming pattern by Naveen Muguda](https://naveenkumarmuguda.medium.com/railway-oriented-programming-a-powerful-functional-programming-pattern-ab454e467f31)

![[Pasted image 20231013095033.png]]

---

## Inversion of Control (IoC)

In [software engineering](https://en.wikipedia.org/wiki/Software_engineering "Software engineering"), **inversion of control** (**IoC**) is a [design pattern](https://en.wikipedia.org/wiki/Software_design_pattern "Software design pattern") in which custom-written portions of a [computer program](https://en.wikipedia.org/wiki/Computer_program "Computer program") receive the [flow of control](https://en.wikipedia.org/wiki/Control_flow "Control flow") from a generic [framework](https://en.wikipedia.org/wiki/Software_framework "Software framework"). The term "inversion" is historical: a [software architecture](https://en.wikipedia.org/wiki/Software_architecture "Software architecture") with this design "inverts" control as compared to [procedural programming](https://en.wikipedia.org/wiki/Procedural_programming "Procedural programming"). In procedural programming, a program's custom code [calls](https://en.wikipedia.org/wiki/Function_call#Main_concepts "Function call") reusable libraries to take care of generic tasks, but with inversion of control, it is the framework that calls the custom code.

Simply put, a component designed according to IoC does not go off and get other components that it needs in order to do its job. It instead _declares_ these dependencies, and the container supplies them. Thus the name IoC/DIP/Hollywood Principle. The control of the dependencies for a given component is inverted. It is no longer the component itself that establishes its own dependencies, but something on the outside. That something could be a container like PicoContainer, but could easily be normal code instantiating the component in an embedded sense.

![[Pasted image 20231017201232.png]]

---

## Messaging Patterns

Closely related to [CQRS - Command and Query Responsibility Segregation](https://learn.microsoft.com/en-us/azure/architecture/patterns/cqrs).

![[Pasted image 20231107140434.png]]


### Command Pattern

Encapsulating a request as an object. Letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

Decoupling the request of an action, with the receiver that executes the action.

Example diagram:
![[Pasted image 20231107135528.png]]

The roles in the diagram in relation to the command pattern:
![[Pasted image 20231107135717.png]]

#### Consequences

![[Pasted image 20231107140304.png]]


### Mediator Pattern

Behavioural pattern.

Define a mediator object that encapsulates how a set of other objects interact, by forcing objects to communicate via that mediator.

Creates loose coupling between the objects that need to communicate with each other, because they are not concerned with how those other objects are implemented.

![[Pasted image 20231107110100.png]]

![[Pasted image 20231107112720.png]]
![[Pasted image 20231107112741.png]]

#### Use Cases and Consequences

![[Pasted image 20231107112353.png]]

![[Pasted image 20231107112504.png]]


#### Implementation Example

Diagram:
![[Pasted image 20231107110355.png]]

How the diagram relates to the mediator pattern:
![[Pasted image 20231107110412.png]]

Code:
```c#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mediator
{
    /// <summary>
    /// Mediator
    /// </summary>
    public interface IChatRoom
    {
        void Register(TeamMember teamMember);
        void Send(string from, string message);
        void Send(string from, string to, string message);
        // Using generic type, but where it needs to be a subclass of TeamMeber
        void SendTo<T>(string from, string message) where T : TeamMember;
    }

    /// <summary>
    /// Colleague
    /// </summary>
    public abstract class TeamMember
    {
        public string Name { get; set; }
        
        private IChatRoom? _chatroom;

        public TeamMember(string name)
        {
            Name = name; 
        }

		// internal makes the method inaccasible from outside this assembly
        internal void SetChatroom(IChatRoom chatRoom)
        {
            _chatroom = chatRoom;
        }

        public void Send(string message)
        {
            _chatroom?.Send(Name, message);
        }

        public void Send(string to, string message)
        {
            _chatroom?.Send(Name, to, message);
        }

        public void SendTo<T>(string message) where T : TeamMember
        {
            _chatroom?.SendTo<T>(Name, message);
        }

		// virtual makes the method overridable with override in subcclasses
        public virtual void Receive(string from, string message)
        {
            Console.WriteLine($"message from {from} to {Name}: {message}");
        }
    }

    /// <summary>
    /// ConcreteColleague
    /// </summary>
    public class Lawyer : TeamMember
    {
        private List<TeamMember> _teamMembersInChat = new();

        public Lawyer(string name) : base(name)
        {
        }

        public override void Receive(string from, string message)
        {
            Console.Write($"{nameof(Lawyer)} {Name} received: ");
            base.Receive(from, message);
        }
    }

    /// <summary>
    /// ConcreteColleague
    /// </summary>
    public class AccountManager : TeamMember
    {
        public AccountManager(string name) : base(name)
        {
        }

        public override void Receive(string from, string message)
        {
            Console.Write($"{nameof(AccountManager)} {Name} received: ");
            base.Receive(from, message);
        }
    }

    /// <summary>
    /// ConcreteMediator
    /// </summary>
    public class TeamChatRoom : IChatRoom
    {
        private readonly Dictionary<string, TeamMember> teamMembers = new();

        public void Register(TeamMember teamMember)
        {
            teamMember.SetChatroom(this);
            if (!teamMembers.ContainsKey(teamMember.Name))
            {
                teamMembers.Add(teamMember.Name, teamMember);
            }
        }

        public void Send(string from, string message)
        {
            foreach (var teamMember in teamMembers.Values)
            {
                teamMember.Receive(from, message);
            }
        }

        public void Send(string from, string to, string message)
        {
            var teamMember = teamMembers[to];
            teamMember?.Receive(from, message); 
        }

        public void SendTo<T>(string from, string message) where T : TeamMember
        {
            foreach (var teamMember in teamMembers.Values.OfType<T>())
            {
                teamMember.Receive(from, message);
            }
        }
    }
}
 
```

Usage:
```c#
using Mediator;

TeamChatRoom teamChatroom = new();

var sven = new Lawyer("Sven");
var kenneth = new Lawyer("Kenneth");
var ann = new AccountManager("Ann");
var john = new AccountManager("John");
var kylie = new AccountManager("Kylie");

teamChatroom.Register(sven);
teamChatroom.Register(kenneth);
teamChatroom.Register(ann);
teamChatroom.Register(john);
teamChatroom.Register(kylie);

ann.Send("Hi everyone, can someone have a look at file ABC123?  I need a compliance check.");
sven.Send("On it!");
sven.Send("Ann", "Could you join me in a Teams call?");
sven.Send("Ann", "All good :)");
ann.SendTo<AccountManager>("The file was approved!");
```

#### Using [MediatR](https://github.com/jbogard/MediatR)

Developed by Jimmy Bogard, the same developer as AutoMapper.

##### Web API Example

![[Pasted image 20231107113051.png]]
![[Pasted image 20231107113154.png]]

Steps:
1. Install the NuGet package.
2. Add MediatR to services:
```c#
// Program.cs
services.AddMediatR(typeof(Startup));
```

3. Add mediator property to the controller and inject the dependency: 
```c#
[Route("api/[controller]")]
[ApiController]
public class TypeNameController : ControllerBase
{
	private IMediator _mediator;

	public TypeNameController(IMediator mediator)
	{
		_mediator = mediator;
	}
}
```

4. Define a Request
```c#
public class RequestName : IRequest<TypeName>
{
	public int Id { get; set; }
}
```

5. Create a Handler for the Request and Type you want to use:
```c#
public class TypeNameHandler : IRequestHandler<RequestName, TypeName>
{
	private dbContextType _dbContext;

	public TypeNameHandler(dbContextType dbContext) => _dbContext = dbContext;

	public Task<TypeName> Handle(
		RequestName request, CancellationToken cancellationToken)
	{
		// action, like a EF query
	}
}
```

6. Use Handler in the API method:
```c#
[HttpGet("{id}")]
public async Task<TypeName> GetType([FromRoute]RequestName request)
{
	await _mediator.Send(request);
}
```


##### [Beyond the Basics](https://medium.com/@cristian_lopes/mediatr-beyond-the-basics-8ab90841a732)

TODO


### Chain of Responsibility Pattern (Decoupling)

- [Article: Decoupling with Chain of Responsibility Pattern in C# by Daniel Rusnok](https://medium.com/net-core/decoupling-with-chain-of-responsibility-pattern-in-c-1273329ed923)
- [Article: Chain of Responsibility Design Pattern with C# Examples by Mohamed Hendawy](https://mohamed-hendawy.medium.com/chain-of-responsibility-design-pattern-in-c-with-examples-d87da6e5ead)

![[Pasted image 20231107140723.png]]
![[Pasted image 20231107141050.png]]

Example: Request Pipeline and Middleware in ASP.NET Core.

A Request Pipeline is what handles a HTTP Request when it comes in, to provide a Response. It is made up off Middleware that handle the request.

Middleware are software components that are assembled into an application pipeline, 
to handle requests and responses. For example, for authentication, or diagnostics.

![[Pasted image 20231018121237.png]]

#### Use Cases and Consequences

![[Pasted image 20231107141239.png]]

![[Pasted image 20231107141325.png]]

### Observer Pattern

When multiple services need to be notified of a change of state without adding coupling.

![[Pasted image 20231107142228.png]]

Example diagram:
![[Pasted image 20231107142523.png]]

Diagram in relation to the observer pattern:
![[Pasted image 20231107142647.png]]

#### Use Cases and Consequences

![[Pasted image 20231107142822.png]]

![[Pasted image 20231107142906.png]]


---

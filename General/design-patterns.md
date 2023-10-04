# Design Patterns

## Courses

- [dotNET academy: SOLID](https://learn.dotnetacademy.be/unit/view/id:8143)
- [YouTube: Change Behaviors with the Strategy Pattern - Unity and C# by One Wheel Studio](https://www.youtube.com/watch?v=yjZsAl13trk)
- [Pluralsight: Clean Architecture: Patterns, Practices, and Principles by Matthew Renze](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)
- [Article: Singleton Pattern in C# by Jallen Liao](https://medium.com/@lancelyao/singleton-pattern-in-c-b2bc4b1e0532)

---

## Introduction

A design pattern is a default solution for common design problems.

History:
- Flow Based Design using Flow Charts to visualize the design.
- Structured Programming says a structured code should have a single start- and end-point, with in between a set of modules.
- Object-Oriented Programming divides the functionality into objects with relations such as composition, references, and inheritance. Resulting in reusable, better readable, and better maintainable code.
- SOLID principles, largely by Robert C. Martin (uncle Bob).
- Today, it is crucial to work Agile, in close cooperation with the customer, and with quick adaptability to market and business strategy changes.


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

## Singleton Pattern

The purpose of Singleton Pattern is to create only one common access to an object, which means the class can only have on instantiation.

Singleton: Single instance shared across the application.

A singleton object is created only once during the lifetime of an application, and the same instance is shared by all components that require it. Subsequent requests for the object will return the same instance. This pattern is useful for objects that should have a global and shared state across the application.

_Example: Let’s say you have a logging service that needs to be accessed by multiple components in your application. By registering the logging service as a singleton, all components will share the same instance, ensuring consistent logging behavior across the application._

*Singleton Pattern Diagram:*
![](https://miro.medium.com/v2/resize:fit:382/1*546cgD2MFxHPKib3FFAZGw.png)

Syntax:
```c#
Singleton instanceName = Singleton.GetInstance;
```

#### Implementing In Custom Class

The **singleton [design pattern](https://www.educative.io/edpresso/design-patterns-in-java)** is used to restrict a class to only one instance at a time. This restriction is achieved by changing the accessibility of the constructor to `private` so that a new instance cannot be created using that constructor from outside the class. The **[static](https://www.educative.io/edpresso/how-to-use-static-keyword-in-java) method** **`GetInstance()`** (defined in the class) creates a new instance after checking if an instance already exists. If it does, the same instance is returned; otherwise, a new instance is created and returned. The **static variable** **`instance`** keeps track of the existing instance of the class.

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


## Chain of Responsibility Pattern (Decoupling)

- [Article: Decoupling with Chain of Responsibility Pattern in C# by Daniel Rusnok](https://medium.com/net-core/decoupling-with-chain-of-responsibility-pattern-in-c-1273329ed923)
- [Article: Chain of Responsibility Design Pattern with C# Examples by Mohamed Hendawy](https://mohamed-hendawy.medium.com/chain-of-responsibility-design-pattern-in-c-with-examples-d87da6e5ead)

---


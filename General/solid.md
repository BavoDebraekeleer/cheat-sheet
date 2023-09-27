# SOLID

## Courses

- [SOLID dotNET academy](https://learn.dotnetacademy.be/unit/view/id:8143)
- [Blog Post: What Are The SOLID Principles? The Art Of Writing Clean And Maintainable Code in C# by Christian Schou](https://blog.christian-schou.dk/what-are-the-solid-principles/)

---

## Introduction

SOLID is an acronym that represents five principles to write good software architecture:
- S –  Single Responsibility Principle
- O –  Open/Closed Principle
- L –  Liskov Substitution Principle
- I – Interface Segregation Principle
- D – Dependency Inversion Principle

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
An abstract class can implement basic functionality and variables all inheriting classes should have. While an interface describes the properties and methods a class should have to implement the interface.
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


---


## L – LSP – Liskov Substitution Principle 📡

The Liskov Substitution Principle (_LSP_) tells us that objects of a superclass should be replaceable with objects of its subclasses without affecting the correctness of the program.

The OOP relation *IS-A* should be replaced with *IS-REPLACABLE-WITH*.

You shouldn't have to perform *Type Checking* or get *Not Implemented Exceptions* to adhere to LSP, including *null checks*.

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

*LSP is keeping watch over your code!*

![[Pasted image 20230927162016.png|100]]


---


## I – ISP – Interface Segregation Principle 😰

You might have guessed it. The Interface Segregation Principle (_ISP_) tells us that our classes should not be forced to implement interfaces is does not use.

---


## D – DIP – Dependency Inversion Principle 🧱

The last principle Dependency Inversion Principle (_DIP_) is responsible for making sure that high-level modules don't depend on low-level modules.

In other words - This principle encourages us to rely on abstractions (interfaces or abstract classes) rather than concrete implementations. By doing so, we can decouple classes and make sure that the code is more maintainable and flexible.

---



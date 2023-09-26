# Test Driven Development (TDD)

## Courses

- [Pluralsight: Implementing C# 9 Unit Testing Using Visual Studio 2019 and .NET 5 by Paul D. Sheriff](https://app.pluralsight.com/library/courses/basic-unit-testing-csharp-developers/table-of-contents)
- [Test Driven Development in C# 8 by Thomas Claudius Huber](https://app.pluralsight.com/library/courses/csharp-test-driven-development/table-of-contents)
- [Course](https://app.pluralsight.com/library/courses/c-sharp-10-unit-testing/table-of-contents?aid=7010a000001xAKZAA2)

## Introduction

Test Driven Design, or TDD for short, makes you think about what the code should do, before you think about how to make it do it, or the implementation.
After implementation, you get fast feedback from your test without even needing a full application.
You are forced to write modular and maintainable code.

Please note the following :
- Unit tests are meant to be fast. Therefore, you would typically not do database or file access during a unit test  
- Unit tests are meant to be easy to set up. Again, database access and setting up a test database is typically for different kinds of tests.

![[Pasted image 20230925143657.png]]

## TDD Cycle

![[Pasted image 20230925142135.png]]

TDD is reiterating through the TDD Cycle to drive implementation.

1. Start with taking a requirement and write a test for it before implementing the code. It fails so it is Red. The test describes what the code should do to succeed.
2. Implement the code to make the test succeed and Green.
3. Refactor the code (both implementation and tests) to make it better.
4. Repeat steps for the next requirement.


## Unit Test

A small automated test, coded by a programmer, that verifies whether or not a small piece of production code – a unit – works as expected in isolation.
A unit typically implements a single feature.

![[Pasted image 20230925215324.png]]

Three testing frameworks available:
- MSTest by Microsoft
- NUnit: a version of JUnit for Java, written now for .NET
- xUnit: basically NUnit v2, so the latest as of writing.

Steps to start testing:
1. Add xUnit Test Project
2. 
## C# Record

A class that only describes what data an object stores, that is immutable and read-only, can be written as a `record` instead of a `class`.
This makes the code more compact and readable.

*Example class:*
```c#
public class MachineDataItem
{
	public MachineDataItem(string CoffeeType, DateTime CreatedAt)
	{
		CoffeeType = CoffeeType;
		CreatedAt = CreatedAt;
	}
	public string CoffeeType { get; } // Only getters, so read-only
	public DateTime CreatedAt { get; }
}
```

*Same example as a record:*
```c#
public record MachineDataItem(string CoffeeType, DateTime CreatedAt);
```

# Test Driven Development (TDD)

## Courses

dotNet:
- [Pluralsight: Implementing C# 9 Unit Testing Using Visual Studio 2019 and .NET 5 by Paul D. Sheriff](https://app.pluralsight.com/library/courses/basic-unit-testing-csharp-developers/table-of-contents)
- [Pluralsight: Test Driven Development in C# 8 by Thomas Claudius Huber](https://app.pluralsight.com/library/courses/csharp-test-driven-development/table-of-contents)
- [Pluralsight: C# 10 Unit Testing by Thomas Claudius Huber](https://app.pluralsight.com/library/courses/c-sharp-10-unit-testing/table-of-contents?aid=7010a000001xAKZAA2) - [My course files](https://github.com/BavoDebraekeleer/dotnet-unit-testing.git)
- [Pluralsight: Clean Architecture: Patterns, Practices, and Principles by Matthew Renze](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)

JavaScript:
- [YouTube: Introduction To Testing In JavaScript With Jest by Web Dev Simplified](https://www.youtube.com/watch?v=FgnxcUQ5vho)
- [YouTube: JavaScript testing: Jest mocks by Codete](https://www.youtube.com/watch?v=OS5mVVM5vAg)
- [YouTube: REACT Testing Crash Course by Traversy Media](https://www.youtube.com/watch?v=OVNjsIto9xM)
- [Teams: Middagsessie dotNet lab – Frontend testing with Jest and Playwright](https://bitconsult365.sharepoint.com/sites/dotNET-Academy-Bitconsult-IT4IT/_layouts/15/stream.aspx?id=%2Fsites%2FdotNET%2DAcademy%2DBitconsult%2DIT4IT%2FGedeelde%20documenten%2FSessions%20%40%20the%20Lab%2FMiddagsessie%5F%20Frontend%20Testing%2D20230417%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview)
- [Testing in React 18 (with Jest and React Testing Library) by Liam McLennan](https://app.pluralsight.com/library/courses/react-18-testing/table-of-contents)


---

## Introduction

Test Driven Design, or TDD for short, makes you think about what the code should do, before you think about how to make it do it, or the implementation.
After implementation, you get fast feedback from your test without even needing a full application.
You are forced to write modular and maintainable code.

Please note the following :
- Unit tests are meant to be fast. Therefore, you would typically not do database or file access during a unit test  
- Unit tests are meant to be easy to set up. Again, database access and setting up a test database is typically for different kinds of tests.

![[Pasted image 20230925143657.png]]

Some examples of tests: 
- Unit test – tests a small piece of code in isolation 
- Integration test – tests component or project as a whole 
- End-to-end test – test entire application from UI to DB and back 
- Service test
- UI test – test UI logic only

![[Pasted image 20230927110429.png]]

- Write tests with different granularity
- The more high-level you get the fewer tests you should have

Stick to the pyramid shape to come up with a healthy, fast and maintainable test suite: Write _lots_ of small and fast _unit tests_. Write _some_ more coarse-grained tests and _very few_ high-level tests that test your application from end to end.

![[Pasted image 20231016200645.png]]
![[Pasted image 20231016200752.png]]


---

## TDD Cycle

![[Pasted image 20230925142135.png]]

TDD is reiterating through the TDD Cycle to drive implementation.

1. Start with taking a requirement and write a test for it before implementing the code. It fails so it is Red. The test describes what the code should do to succeed.
2. Implement the code to make the test succeed and Green.
3. Refactor the code (both implementation and tests) to make it better.
4. Repeat steps for the next requirement.

---

## Unit Test

A small automated test, coded by a programmer, that verifies whether or not a small piece of production code – a unit – works as expected in isolation.
A unit typically implements a single feature.

*A test is not a unit test if: it talks to the database, or it communicates across the network, or it touches the file system, or you need to edit configuration files to start.*

SUT = System Under Test

![[Pasted image 20230925215324.png]]

### Parts of a Unit Test

1. Arrange: arranges everything that is needed for the test, the prerequisites, or test data.
2. Act: what you actually want to test, for example a specific method.
3. Assert: state the fact of what the result should be.

[Blog Post: Economy of Tests by Stakeholder Whisperer](https://stakeholderwhisperer.com/posts/2015/1/economy-of-tests#_=_)

### Back-end Testing

dotNet Lab works with:
- [xUnit](https://xunit.net/)
- [NSubstitute](https://nsubstitute.github.io/)

#### xUnit

[Getting Started – Official xUnit Documentation](https://xunit.net/docs/getting-started/netcore/visual-studio)

Steps to start testing:
1. Add xUnit Test Project: Right Click on Solution > Add > New Project > xUnit Test Project.
2. Update Dependencies: Right Click on Dependencies > Manage NuGet Packages > Updates (Top) > Select all packages > Update ( > Apply > Accept ).
3. Add Project reference of the project you want to test: Right Click on Dependencies of the Test Project > Add Project Reference > Select the project > OK.
4. Use the same namespace: Right Click on Test Project > Properties > Default namespace: (write the namespace used by the project to test) > Save.
5. Mirror the project folder structure of the project to test in the Test Project.
6. Add a Test Class: Right Click on Folder > Add > Class > Class > Give a name, ending on “Tests” > Add.
7. Make class `public` and add *Tests* to calss name.
8. Create a testing method `public void NameIsWhatTheTestShouldDo(){}` with the needed [[#Testing Attributes]].
9. Arrange: Write test data.
10. Act: Write what the test should test.
11. Assert: Use `Assert.` to write the actual test.
12. Implement or Debug code to make the test succeed / green.
13. Refactor code.

![[Pasted image 20230926103553.png]]

##### Test Project Properties

The properties of the project should look something like this:
```xml
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFramework>net5.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.NET.Test.Sdk" Version="16.7.1" />
    <PackageReference Include="xunit" Version="2.4.1" />
    <PackageReference Include="xunit.runner.visualstudio" Version="2.4.3">
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
      <PrivateAssets>all</PrivateAssets>
    </PackageReference>
    <PackageReference Include="coverlet.collector" Version="1.3.0">
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
      <PrivateAssets>all</PrivateAssets>
    </PackageReference>
  </ItemGroup>

</Project>
```

- `TargetFramework` specifies the target framework for your test project. By default, this will be the latest version of .NET Core that your system supports (in this example, .NET 5.0). To test against multiple: `<TargetFrameworks>net48;net5.0</TargetFrameworks>`.
- `IsPackable` is here, though it is redundant (unit test projects cannot be packed by default). You can safely remove this line if you wish.
- The `xunit` package brings in three child packages which include functionality that most developers want: `xunit.core` (the testing framework itself), `xunit.assert` (the library which contains the `Assert` class), and `xunit.analyzers` (which enables Roslyn analysers to detect common issues with unit tests and xUnit.net extensibility).
- The packages `xunit.runner.visualstudio` and `Microsoft.NET.Test.Sdk` are required for being able to run your test project inside Visual Studio as well as with `dotnet test`.
- The `coverlet.collector` package allows collecting code coverage. If you don't intend to collect code coverage, you should remove this package reference.

##### Testing Attributes

Types of xUnit Tests:
- \[Fact] tests are always true. They test invariant conditions, and have no parameters.
- \[Theory] or Data-driven Tests are tests which are only true for a particular set of data. They have parameters.

###### \[Fact]

*Example 1:*
```c#
using Xunit;

namespace MyFirstUnitTests
{
    public class UnitTest1
    {
        [Fact] // Testing attribute to set type of test
        public void PassingTest()
        {
            Assert.Equal(4, Add(2, 2));
        }

        [Fact]
        public void FailingTest()
        {
            Assert.Equal(5, Add(2, 2));
        }

        int Add(int x, int y)
        {
            return x + y;
        }
    }
}
```

*Example 2:*
```c#
public class CsvLineParserTests
{
    [Fact]
    public void ShouldParseValidLine()
    {
	    // 1. Arrange
        string[] csvLines = new[] { "Espresso;10/27/2022 8:07:34 AM" };
		
		// 2. Act
        var machineDataItems = CsvLineParser.Parse(csvLines);

		// 3. Assert
        Assert.NotNull(machineDataItems);
        Assert.Single(machineDataItems);
        Assert.Equal("Espresso", machineDataItems[0].CoffeeType);
        Assert.Equal(
	        new DateTime(2022, 10, 27, 8, 6, 4), 
	        machineDataItems[0].CreatedAt);
    }
}
```

[Parse DateTime](https://learn.microsoft.com/en-us/dotnet/api/system.datetime.parse?view=net-7.0) for US format:
`DateTime.Parse("10/27/2022 8:07:34 AM", CultureInfo.CreateSpecificCulture("en-US"))`

###### \[Theory] or Data-driven Tests

Using the `[Theory]` attribute together with `[InlineData]` that represents different values that can be passed to the parameters.

*Example:*
```c#
[Theory] // Testing attribute to set type of test
[InlineData(DeskBookingResultCode.Succes, true)] // Testing attribute
[InlineData(DeskBookingResultCode.NoDeskAvailable, false)]
public void ShouldReturnExpectedResultCode(
	DeskBookingResultCode expectedResultCode, bool isDeskAvailable)
{
	if (!isDeskAvailable)
	{
		_availableDesk.Clear();_
	}
	var result = _processor.BookDesk(_request);

	Assert.Equal(expectedResultCode, result.Code); // Assert is part of xUnit
	// The result code returned by the request processor is compared against the expected result to see if it is the same / equal.
}
```


#### Decouple Dependencies

*Explained in [C# 10 Unit Testing by Thomas Claudius Huber](https://app.pluralsight.com/library/courses/c-sharp-10-unit-testing/table-of-contents?aid=7010a000001xAKZAA2) in the **Writing Testable Code** module.*

Decoupling Dependencies can be necessary to make code testable.
Here the [*Single Responsibility Principle*](https://blog.christian-schou.dk/what-are-the-solid-principles/) comes into play:

>A `class` should have only one reason to change, meaning it should have only one responsibility or job.

##### [*Single Responsibility Principle*](https://blog.christian-schou.dk/what-are-the-solid-principles/)

*The following class has two responsibilities:*
```c#
using System.IO;

public class Book
{
	// Responsibility 1: book information.
    public string Title { get; set; }
    public string Author { get; set; }
    public int NumberOfPages { get; set; }

    // Responsibility 2: saving the book info to a file.
    public void SaveToFile(string fileName)
    {
        string bookInfo = $"{Title},{Author},{NumberOfPages}";
        File.WriteAllText(fileName, bookInfo);
    }
}

```

*To decouple the dependencies each responsibility is refactored into its own class:*
```c#
// Book class is responsible for book information only
public class Book
{
    public string Title { get; set; }
    public string Author { get; set; }
    public int NumberOfPages { get; set; }
}

// BookFileHandler class is responsible for saving book information to a file
public class BookFileHandler
{
    public void SaveToFile(Book book, string fileName)
    {
        string bookInfo = $"{book.Title},{book.Author},{book.NumberOfPages}";
        File.WriteAllText(fileName, bookInfo);
    }
}

```

##### Decoupling Using Interfaces

Another method to decouple dependencies is to implement an Interface.
The following class has two responsibilities, which makes testing the code impossible:

![[Pasted image 20230926143611.png]]

We need to separate the second responsibility by implementing it in an Interface:

![[Pasted image 20230926143849.png]]

This way it is very easy to switch out the output, so that, for example, the output is not written to the console, but pushed to a Web API, or saved to a file:

![[Pasted image 20230926144047.png]]

For the Unit Test, the Interface is used to fake the output, so the first responsibility can be tested seperatley:

![[Pasted image 20230926144208.png]]

In the code it looks like this:

*Original class:*
```c#
using WiredBrainCoffee.DataProcessor.Model;

namespace WiredBrainCoffee.DataProcessor.Processing;

public class MachineDataProcessor
{
    private readonly Dictionary<string, int> _countPerCoffeeType = new();

    public void ProcessItems(MachineDataItem[] dataItems)
    {
        _countPerCoffeeType.Clear();

        foreach (var dataItem in dataItems)
        {
            ProcessItem(dataItem);
        }

        SaveCountPerCoffeeType();
    }

    private void ProcessItem(MachineDataItem dataItem)
    {
        if (!_countPerCoffeeType.ContainsKey(dataItem.CoffeeType))
        {
            _countPerCoffeeType.Add(dataItem.CoffeeType, 1);
        }
        else
        {
            _countPerCoffeeType[dataItem.CoffeeType]++;
        }
    }

    private void SaveCountPerCoffeeType()
    {
        foreach (var entry in _countPerCoffeeType)
        {
            var line = $"{entry.Key}:{entry.Value}";
            Console.WriteLine(line);
        }
    }
}

```

TO

*Decoupled class:*
```c#
using WiredBrainCoffee.DataProcessor.Data;
using WiredBrainCoffee.DataProcessor.Model;

namespace WiredBrainCoffee.DataProcessor.Processing;

public class MachineDataProcessor
{
    private readonly Dictionary<string, int> _countPerCoffeeType = new();
    private readonly ICoffeeCountStore _coffeeCountStore;

    public MachineDataProcessor(ICoffeeCountStore coffeeCountStore) // type "ctor" to create a constructor
    {
        _coffeeCountStore = coffeeCountStore;
    }

    // ... (still the same)

    private void SaveCountPerCoffeeType()
    {
        foreach (var entry in _countPerCoffeeType)
        {
            _coffeeCountStore.Save(new CoffeeCountItem(entry.Key, entry.Value));
        }
    }
}

```

*Interface:*
```c#
using WiredBrainCoffee.DataProcessor.Model;

namespace WiredBrainCoffee.DataProcessor.Data;

public interface ICoffeeCountStore
{
    void Save(CoffeeCountItem item);
}

```

*Output class:*
```c#
using WiredBrainCoffee.DataProcessor.Model;

namespace WiredBrainCoffee.DataProcessor.Data;

public class ConsoleCoffeeCountStore : ICoffeeCountStore
{
    public void Save(CoffeeCountItem item)
    {
        var line = $"{item.CoffeeType}:{item.Count}";
        Console.WriteLine(line);
    }
}
```


#### Run Code BEFORE every Test

To run code before every test, meaning outside the test methods with the test attributes.
This is useful for repeating code, for example to create objects used in multiple tests.

Steps:
1. Write “ctor” to generate a constructor for the *Tests* class.
2. Copy the repeating object declaration into the constructor.
3. Delete the `var` or datatype keywords.
4. Use *Ctrl+;* to *Generate read-only field* for the objects.

#### Run Code AFTER every Test

To run code after every test, for example to do some cleaning up like deleting a file that was created during testing, implement the IDisposable interface in the Tests class.

`public class Tests : IDisposable` and *Ctrl+;* to *Implement interface*.

This will implement the *Dispose* method that will run after all tests are finished.

#### Mock Dependencies in Tests

##### Mock Console Output

To mock the output to a console:
1. Implement a TextWriter where the Console ouput is.
2. Implement a Constructor that takes a TexWriter object as parameter.
3. Implement another overloaded Constructor that implements `Console.Out`.

*Example:*
```c#
using WiredBrainCoffee.DataProcessor.Model;

namespace WiredBrainCoffee.DataProcessor.Data;

public class ConsoleCoffeeCountStore : ICoffeeCountStore
{
    private readonly TextWriter _textWriter;

    public ConsoleCoffeeCountStore() : this(Console.Out) { }
    public ConsoleCoffeeCountStore(TextWriter textWriter)
    {
        _textWriter = textWriter;
    }
    public void Save(CoffeeCountItem item)
    {
        var line = $"{item.CoffeeType}:{item.Count}";
        _textWriter.WriteLine(line);
    }
}
```

*Example test that uses the above class:*
```c#
using WiredBrainCoffee.DataProcessor.Model;

namespace WiredBrainCoffee.DataProcessor.Data;

public class ConsoleCoffeeCountStoreTests
{
    [Fact]
    public void ShouldWriteOutputToConsole()
    {
        // 1. Arrange
        var item = new CoffeeCountItem("Latte", 5);
        var stringWriter = new StringWriter(); // StringWriter inherits from TextWriter, but is specifically for strings.
        var consoleCoffeeCountStore = new ConsoleCoffeeCountStore();

        // 2. Act
        consoleCoffeeCountStore.Save(coffeeCountItem);

        // 3. Assert
        var result = stringWriter.ToString();
        Assert.Equal(
            $"{item.CoffeeType}:{item.Count}{Environment.NewLine}",
            result ); // "Latte:5/r/n"
    }
}
```

##### [NSubstitute](https://nsubstitute.github.io/help/getting-started/)

NSubstitute is a mocking library for .NET to fake Interfaces. 

Steps:
1. First add the [NSubstitute NuGet package](https://nuget.org/List/Packages/NSubstitute) to your test project using [NuGet](https://docs.microsoft.com/en-us/nuget/quickstart/use-a-package). It is optional but recommended to also install [NSubstitute.Analyzers.CSharp](https://www.nuget.org/packages/NSubstitute.Analyzers.CSharp/) for C# projects

```
> Install-Package NSubstitute
> Install-Package NSubstitute.Analyzers.CSharp
```

2. Add `using NSubstitute;`
3. Implementation, for example:

```c#
public interface ICalculator
{
    int Add(int a, int b);
    string Mode { get; set; }
    event EventHandler PoweringUp;
}
```

```c#
//Create a substitute of the Interface needed:
var calculator = Substitute.For<ICalculator>();

//Set a return value for the sub if called:
calculator.Add(1, 2).Returns(3);
Assert.AreEqual(3, calculator.Add(1, 2));

//Check received calls:
calculator.Received().Add(1, Arg.Any<int>());
calculator.DidNotReceive().Add(2, 2);

//Raise events
calculator.PoweringUp += Raise.Event();
```

If our `Received()` assertion fails, NSubstitute tries to give us some help as to what the problem might be:
```c#
ReceivedCallsException : Expected to receive a call matching:
    Add(1, 2)
Actually received no matching calls.
Received 2 non-matching calls (non-matching arguments indicated with '*' characters):
    Add(*4*, *7*)
    Add(1, *5*)
```

We can also work with properties using the `Returns` syntax we use for methods, or just stick with plain old property setters (for read/write properties):
```c#
calculator.Mode.Returns("DEC");
Assert.That(calculator.Mode, Is.EqualTo("DEC"));

calculator.Mode = "HEX";
Assert.That(calculator.Mode, Is.EqualTo("HEX"));
```

NSubstitute supports [argument matching](https://nsubstitute.github.io/help/argument-matchers/) for setting return values and asserting a call was received:
```c#
calculator.Add(10, -5);
calculator.Received().Add(10, Arg.Any<int>());
calculator.Received().Add(10, Arg.Is<int>(x => x < 0));
```

`Returns()` can also be called with multiple arguments to set up a sequence of return values:
```c#
calculator.Mode.Returns("HEX", "DEC", "BIN");
Assert.That(calculator.Mode, Is.EqualTo("HEX"));
Assert.That(calculator.Mode, Is.EqualTo("DEC"));
Assert.That(calculator.Mode, Is.EqualTo("BIN"));
```


#### [SpecFlow](https://docs.specflow.org/projects/getting-started/en/latest/index.html)

SpecFlow is a package and Visual Studio extension that allows you to write your test as a test scenario, and it will convert those scenarios into unit test.

Steps:
1. NuGet packages `SpecFlow` and `SpecFlow.xUnit`.
2. Install the SpecFlow extension in Visual Studio.
3. Add a new SpecFlow Feature File to your test project and write you test scenario, for example:
```SpecFlow
Feature: Calculator 
       In order to avoid silly mistakes 
       As a math idiot 
       I want to be told the sum of two numbers
```

```SpecFlow
Scenario: Add two numbers 
       Given I have entered 50 into the calculator 
       And I have also entered 70 into the calculator 
       When I press add 
       Then the result should be 120 on the screen
```

4. Save this file/build your project and SpecFlow will generate a `.cs` file for this test scenario.


#### DateTime Difficulties

##### Current Date

Using the current day in code can give issues in unit tests.
Instead of `DateTime.Today` use `SystemTime.Today` instead to set a date.

Steps:
1. Set a date:
```c#
// Instead of:
var today = DateTime.Today;

// Use:
SystemTime.Today = () => new DateTime(2019, 5, 1);
var today = SystemTime.Today();
```

##### Parsing

[Parse DateTime](https://learn.microsoft.com/en-us/dotnet/api/system.datetime.parse?view=net-7.0) for US format:
`DateTime.Parse("10/27/2022 8:07:34 AM", CultureInfo.CreateSpecificCulture("en-US"))`

---

### Running Unit Tests Automatically

#### .NET CLI

Steps:
1. Open Terminal in the Solution folder.
2. Run command: `dotnet test`

![[Pasted image 20230926174735.png]]

#### GitHub Actions

With GitHub Actions, the tests can be run automatically everytime code is pushed to the repository.

Steps:
1. Create a GitHub repository and push the code to it.
2. Go to the GitHub repository > Actions
3. Now the right Workflow needs to be selected. For the example project this is *.NET* under *Continuous Integration* > Configure.
4. This creates a `.yml` file with the build instructions.
5. Specify the working-directory if the solution is not in the root folder. 
6. Commit changes > Commit directly to the `main` branch.

![[Pasted image 20230926180030.png]]

```YML TI:"build.yml"
# This workflow will build a .NET project
# For more information see: https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-net

name: Build

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: 6.0.x
    - name: Restore dependencies
      run: dotnet restore
    - name: Build
      run: dotnet build --no-restore
    - name: Test
      run: dotnet test --no-build --verbosity normal
```

The resulting actions:
![[Pasted image 20230926180332.png]]
...
![[Pasted image 20230926180407.png]]

The `.yml` file in Visual Studio in Folder View:
![[Pasted image 20230926180904.png]]
(Double Click on the `.sln` file to go back to Solution View)

#### Working-directory

If the solution is not in the root folder of your repository you need to specify in which folder/directory the solution is located for each step.

Syntax:
```yml
jobs:
  build:

    runs-on: os-image

    steps:
    - uses: actions/version
    - name: Step Name
      run: command
	  working-directory: folderOInRoot/folderInThatFolder
```

*Example:*
```yml
# This workflow will build a .NET project
# For more information see: https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-net

name: .NET

on:
  push:
    branches: [ "MASTERBAV-3" ]
  pull_request:
    branches: [ "MASTERBAV-3" ]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: 6.0.x
    - name: Restore dependencies
      run: dotnet restore
      working-directory: solid-fundamentals
    - name: Build
      run: dotnet build --no-restore
      working-directory: solid-fundamentals
    - name: Test
      run: dotnet test --no-build --verbosity normal
      working-directory: solid-fundamentals

```

---

### Front-end Testing

dotNet Lab works with:
- [Jest](https://jestjs.io/) for JavaScript and TypeScript testing.
	- Mocks
	- Spies
	- Snapshots

#### [Jest](https://jestjs.io/docs/getting-started)

##### JavaScript

Steps:
1. Install Jest using npm, as a development dependency. This adds Jest to the `devDependencies` in `package.json`:
```cli
npm install --save-dev jest
```

2. In `package.json` add/change:
   *The `--coverage` generates statistics and a report webpage to see if all code is tested.*
```js
{  
	"scripts": {  
		"test": "jest --coverage"  
	}  
}
```

3. Write tests, for example:
```js
const sum = require('./sum');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

4. Run `npm test` to execute the tests.
```cli
PASS  ./sum.test.js
✓ adds 1 + 2 to equal 3 (5ms)
```

##### Writing Tests with [Expect](https://jestjs.io/docs/expect)

Steps:
1. Create new file with same name as the file you want to test and add `.test`, for example the file to test is `sum.js`, so the test file is `sum.test.js`.
2. Export the code to test, e.g. `module.exports = sum` to export a function called `sum` in `sum.js`.
3. Import the to test code in the test file, e.g. `const sum = require('./sum')`.
4. Use the `test` function to write a test and describe what the test should do in text, e.g.:
```js HL="3"
const sum = require('./sum')

test('properly adds two numbers', () => {
	// test code
})
```

5. Use the `expect` function to describe what the test should do in code, e.g.:
```js HL="4"
const sum = require('./sum')

test('properly adds two numbers', () => {
	expect(sum(1, 2)).toBe(3)
})
```

##### Test Functions

- `sum`
- `substract`

##### Matchers or Relational Operators

- `toBe` checks equality by reference.
- `toEqual` checks equality by value.
- `toStrictEqual` also takes into account object keys with `undefined` properties, `undefined` array items, array sparseness, or object type mismatch.
- `toBeCloseTo` checks floating point equality, because you don't want a test to depend on a tiny rounding error, e.g.:
```js
test('adding floating point numbers', () => {
  const value = 0.1 + 0.2;
  //expect(value).toBe(0.3);           This won't work because of rounding error
  expect(value).toBeCloseTo(0.3); // This works.
});
```

- `toMatch` checks strings against regular expressions, e.g.:
```js
test('there is no I in team', () => {  
expect('team').not.toMatch(/I/);  
});  
  
test('but there is a "stop" in Christoph', () => {  
expect('Christoph').toMatch(/stop/);  
});
```

- `toBeGreaterThan`
- `toBeGreaterThanOrEqual`
- `toBeLessThan`
- `toBeLessThanOrEqual`

- `toBeNull` matches only `null`
- `toBeUndefined` matches only `undefined`
- `toBeDefined` is the opposite of `toBeUndefined`
- `toBeTruthy` matches anything that an `if` statement treats as true
- `toBeFalsy` matches anything that an `if` statement treats as false

- `toContain` checks if an array or iterable contains a particular item, e.g.:
```js
const shoppingList = [
  'diapers',
  'kleenex',
  'trash bags',
  'paper towels',
  'milk',
];

test('the shopping list has milk on it', () => {
  expect(shoppingList).toContain('milk');
  expect(new Set(shoppingList)).toContain('milk');
});
```

- `toThrow` checks whether a particular function throws an error when it's called, e.g.:
  *! The function that throws an exception needs to be invoked within a wrapping function otherwise the `toThrow` assertion will fail.*
```js
function compileAndroidCode() {
  throw new Error('you are using the wrong JDK!');
}

test('compiling android goes as expected', () => {
  expect(() => compileAndroidCode()).toThrow();
  expect(() => compileAndroidCode()).toThrow(Error);

  // You can also use a string that must be contained in the error message or a regexp
  expect(() => compileAndroidCode()).toThrow('you are using the wrong JDK');
  expect(() => compileAndroidCode()).toThrow(/JDK/);

  // Or you can match an exact error message using a regexp like below
  expect(() => compileAndroidCode()).toThrow(/^you are using the wrong JDK$/); // Test fails
  expect(() => compileAndroidCode()).toThrow(/^you are using the wrong JDK!$/); // Test pass
});
```

##### Modifiers or Logic Operators

- [`.not`](https://jestjs.io/docs/expect#not) checks opposite.
- [`.resolves`](https://jestjs.io/docs/expect#resolves) unwraps the value of a fulfilled promise so any other matcher can be chained. If the promise is rejected the assertion fails.
- [`.rejects`](https://jestjs.io/docs/expect#rejects) unwraps the reason of a rejected promise so any other matcher can be chained. If the promise is fulfilled the assertion fails.

*Example:*
```js
const cloneArray = require('./cloneArray')

test('properly clones array', () => {
	// 1. Arrange
	const array = [1, 2, 3]

	// 2. Act and 3. Assert
	expect(cloneArray(array)).toEqual(array) // Checks if the value is the same
	expect(cloneArray(array)).not.toBe(array) // Checks if it is actually a duplicate and so does not have the same reference / memory address.
})
```
##### Running from Command Line

Install globally with:
```cli
npm install jest --global
```

Run test:
```cli
jest my-test --notify --config=config.json
```

##### [Mock Functions, Spies and Mocks](https://jestjs.io/docs/mock-function-api)

[Short video on Jest Mocks](https://www.youtube.com/watch?v=OS5mVVM5vAg) - [used examples](https://github.com/kwieccia/jest-mocks-101)

- Function Mocks `jest.fn()` lets you verify how a function was used by the tested unit.
- Spies `jest.spyOn()` + `.mockImplementation()` lets you replace or simulate functions.
- Mocks `jest.mock()` lets you replace entire modules.
- `jest.doMock` to use when hoisting is an issue (see video).

- `jest.clearAllMocks()` clean-up function to run between every Function Mock test:
```js
afterEach(() => {
	jest.clearAllMocks();
})
```
- `jest.restoreAllMocks()` clean-up for Spies.

*Function Mock example:*
![[Pasted image 20230927103226.png]]

*Spy example:*
![[Pasted image 20230927103100.png]]

*Mock example 1 replaces both functions:*
![[Pasted image 20230927104319.png]]

*Mock example 2 keeps the original first function, but replaces the second:*
![[Pasted image 20230927104447.png]]

More examples of mocking:
- JSON configuration:
  ![[Pasted image 20230927104831.png]]

- External Node Modules:
  ![[Pasted image 20230927104904.png]]

- React Components:
  ![[Pasted image 20230927104937.png]]

###### Global Mocks

To make a mock present in all tests:

![[Pasted image 20230927105101.png]]

*Example that gives mock user geolocation info:*
![[Pasted image 20230927105431.png]]


##### [Snapshot Testing](https://jestjs.io/docs/snapshot-testing)

Snapshot tests are a very useful tool whenever you want to make sure your UI does not change unexpectedly. A typical snapshot test case renders a UI component, takes a snapshot, then compares it to a reference snapshot file stored alongside the test. The test will fail if the two snapshots do not match: either the change is unexpected, or the reference snapshot needs to be updated to the new version of the UI component.

A similar approach can be taken when it comes to testing your React components. Instead of rendering the graphical UI, which would require building the entire app, you can use a test renderer to quickly generate a serializable value for your React tree. Consider this [example test](https://github.com/jestjs/jest/blob/main/examples/snapshot/__tests__/link.test.js) for a [Link component](https://github.com/jestjs/jest/blob/main/examples/snapshot/Link.js):
```js
import renderer from 'react-test-renderer';
import Link from '../Link';

it('renders correctly', () => {
  const tree = renderer
    .create(<Link page="http://www.facebook.com">Facebook</Link>)
    .toJSON();
  expect(tree).toMatchSnapshot();
});
```

The first time this test is run, Jest creates a [snapshot file](https://github.com/jestjs/jest/blob/main/examples/snapshot/__tests__/__snapshots__/link.test.js.snap) that looks like this:
```
exports[`renders correctly 1`] = `
<a
  className="normal"
  href="http://www.facebook.com"
  onMouseEnter={[Function]}
  onMouseLeave={[Function]}
>
  Facebook
</a>
`;
```

The snapshot artifact should be committed alongside code changes, and reviewed as part of your code review process. Jest uses [pretty-format](https://github.com/jestjs/jest/tree/main/packages/pretty-format) to make snapshots human-readable during code review. On subsequent test runs, Jest will compare the rendered output with the previous snapshot. If they match, the test will pass. If they don't match, either the test runner found a bug in your code (in the `<Link>` component in this case) that should be fixed, or the implementation has changed and the snapshot needs to be updated.


##### [Testing Asynchronous Code](https://jestjs.io/docs/asynchronous)

It's common in JavaScript for code to run asynchronously. When you have code that runs asynchronously, Jest needs to know when the code it is testing has completed, before it can move on to another test. Jest has several ways to handle this:

- Promises
- Async/Await
- Callbacks
- `.resolves` and `.rejects`

*See official documentation.*


##### TypeScript

###### via Babel

Steps:
1. To use [Babel](https://babeljs.io/) install required dependencies: 
```cli
npm install --save-dev babel-jest @babel/core @babel/preset-env
```

2. Configure Babel to target your current version of Node by creating a `babel.config.js` file in the root of your project:
```js
module.exports = {
  presets: [['@babel/preset-env', {targets: {node: 'current'}}]],
};
```

3. Next, install the `@babel/preset-typescript`:
```cli
npm install --save-dev @babel/preset-typescript
```

4. Then add `@babel/preset-typescript` to the list of presets in your `babel.config.js`:
```js
module.exports = {
  presets: [
    ['@babel/preset-env', {targets: {node: 'current'}}],
    '@babel/preset-typescript',
  ],
};
```

*However, there are some [caveats](https://babeljs.io/docs/en/babel-plugin-transform-typescript#caveats) to using TypeScript with Babel. Because TypeScript support in Babel is purely transpilation, Jest will not type-check your tests as they are run. If you want that, you can use [ts-jest](https://github.com/kulshekhar/ts-jest) instead, or just run the TypeScript compiler [tsc](https://www.typescriptlang.org/docs/handbook/compiler-options.html) separately (or as part of your build process).*

#### [`jest-dom`](https://testing-library.com/docs/ecosystem-jest-dom/)

Provides better readable methods, e.g.:
![[Pasted image 20231103164314.png]]

![[Pasted image 20231103164347.png]]

#### React Testing Library

The React Testing Library is a React specific wrapper of the DOM Testing Library.

![[Pasted image 20231103153359.png]]

For testing of:
- Rendering
- User Interactions

![[Pasted image 20231104114053.png]]

##### Rendering a Component

```js
import { render } from '@testing-library/react'

render( <ComponentName /> )
```

##### Element Query Types

![[Pasted image 20231103155541.png]]

##### Element Selection Types

Recommended is `..ByRole`.
The following are in most (top) to least (bottom) desirable, so choose from top to bottom which one works for the test.

![[Pasted image 20231103155755.png]]

##### ARIA Role Types

```js
const heading = screen.getByRole('heading', {
	name: "Filter List",
})
```

In this example:
- `'heading'` is the ARIA Role.
- `get` will throw an error if there is more than one result.
- further restricions are set between `{}`, here `{name: "Filter List"}` will restrict the result to an element with the accessible name of Filter List.
- The `screen` object provides methods to search the rendered components.

##### Finding Nested Elements

```js
import { render, screen, getByRole } from '@testing-library/react'
import Home from '@/pages/index'

test('Home renders a nested heading', () => {
	render(<Home />);

	// Home renders the heading element within a main element.
	// The main element can be get from the screen:
	const main = screen.getByRole('main');

	// The heading element is within the main, not directly in screen,
	// so a detached version of getByRole can be used where the element it
	// has to search in is passed to it.
	getByRole(main, 'heading', {
		name: "Filter List"	
	});
});
```

![[Pasted image 20231103161439.png]]

##### Debugging Components

Use the following to receive the element in the console:
```js
screen.debug(screen.getByPlaceholderText("Filter"));
```

To identify the role of elements, use `logRoles()`:
```js
const list = screen.getByRole('list', {
	name: /Filtered list/
});
logRoles(list);  // Logs the given element tree to the console.
```

![[Pasted image 20231103163210.png]]

###### Log Playground URL

![[Pasted image 20231103163309.png]]

At the link:
![[Pasted image 20231103163342.png]]

##### Testing Asynchronous Rendering

Challenging, because the result may not be present yet.

![[Pasted image 20231103163651.png]]

The test method must be `async` and the test function awaited, or the test will never fail.

##### Interaction APIs

- `user-event`
- `fireEvent` — simple, but not super accurate in the way an actual human would interact.

###### `user-event` API

- Asynchronous - use await.
- Call `setup()` before rendering.

![[Pasted image 20231104110858.png]]

###### `fireEvent` API

- Thin wrapper around the browser's Despatch Event API.
- Allows to trigger any event on any element, e.g. `change` on a form that triggers `onChange`of the form or field.
- Doesn't interact exactly as a user would.
- Synchronous and no setup required.

![[Pasted image 20231104111259.png]]

##### Snapshot Testing

- For detecting regressions - verifying that specific representations of the application do not change.
- Verify specific implementation.
- For testing application areas that are unlikely to change.
- Not for areas in active development.

##### Testing Components with State

Adds the context of time to your testing. You have to wait till a state change or effect has taken place.

###### `useState`

This way of testing is also applicable for other mechanisms like [`useReducer`](https://react.dev/reference/react/useReducer), [React Redux](https://react-redux.js.org/), or [MobX](https://mobx.js.org/getting-started).

Make sure to refactor your components so that the handling of the State is wrapped in an outer component. All other logic can be put in a “pure” inner component that receives all it needs through props, from the stateful outer wrapper component. 
This makes the code more testable, and applies SRP.


![[Pasted image 20231104113925.png]]

![[Pasted image 20231104114053.png]]

Example Renedering tests:
```tsx
describe('FilterList', () => {
  describe('rendering', () => {
    it('should render a filter input', () => {
      renderPlanets();
      screen.getByPlaceholderText(/Filter/i);
    });

    it('should render planets', () => {
      renderPlanets();
      for (let planet of planets) {
        screen.getByText(planet);
      }
      expect(screen.queryByText('Pluto')).toBeNull();
    });

    describe('filtered', () => {
      it("should render no items when filter is `xqz`", () => {
        const props = {
          ...defaultProps,
          items: planets,
          filter: 'xqz',
        }
        render(<FilterListPure { ...props } />)
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const listItems = queryAllByRole(list, 'listitem');
        expect(listItems).toHaveLength(0);;
      });

      it("should render 'Earth' and 'Mars' when filtered with 'ar'", () => {
        const props = {
          ...defaultProps,
          items: planets,
          filter: 'ar',
        }

        render(<FilterListPure {...props} />)
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const listItems = queryAllByRole(list, 'listitem');
        expect(listItems).toHaveLength(2);
        expect(getByText(list, /earth/i));
        expect(getByText(list, /mars/i));
      });
    })

    describe('selection', () => {
      it("should render list items without the 'selected' class", () => {
        renderPlanets();
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const listItems = queryAllByRole(list, 'listitem');
        for (let listitem of listItems) {
          expect(listitem.className).not.toMatch(/selected/);
        }
      })

      it("should render 'Earth' with 'selected' class when 'Earth' is selected", () => {
        const props = {
          ...defaultProps,
          items: planets,
          selectedItems: ['Earth']
        };
        render(<FilterListPure {...props} />)
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const listItems = queryAllByRole(list, 'listitem');
        for (let listitem of listItems) {
          if (/earth/i.test(listitem.textContent || '')) {
            expect(listitem).toHaveClass('selected');
          } else {
            expect(listitem).not.toHaveClass('selected');
          }
        }
      })
    })
  });
});

export const planets = ['Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']

export const defaultProps = {
  filter: '',
  selectedItems: [],
  onFilterChange: ()=>{},
  onItemSelection: ()=>{},
};

export function renderPlanets() {  
  render(<FilterListPure items={planets} {...defaultProps} />);
}
```

Example Interaction Tests:
```tsx
describe('FilterList', () => {
  describe('interaction - user-events', () => {
    describe('filtering', () => {
      it('should filter by parts of words', async () => {
        const user = userEvent.setup();
        render(<FilterList items={listOfMetals} onChange={ ()=>{} }/>);
        const filterInput = screen.getByPlaceholderText(/Filter/i);
        await user.type(filterInput, 'mi');
        expectOnlyItems([/Aluminium/i, /Chromium/i]);
      });
    });

    describe('selection', () => {
      it('should select unselected items that are clicked', async () => {
        const user = userEvent.setup();
        render(<FilterList items={listOfMetals} onChange={ ()=>{} }/>);
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const potassium = within(list).getByText(/Potassium/i);
        await user.click(potassium);
        expect(potassium).toHaveClass('selected');
      });

      it('should unselect selected items that are clicked', async () => {
        const user = userEvent.setup();
        render(<FilterList items={listOfMetals} onChange={ ()=>{} }/>);
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const beryllium = within(list).getByText(/Beryllium/i);
        await user.click(beryllium); // select Beryllium
        await user.click(beryllium); // unselect Beryllium
        expect(beryllium).not.toHaveClass('selected');
      });
    });
  });

  describe('interaction - fireEvent', () => {
    describe('filtering', () => {
      it('should filter by parts of words', () => {
        render(<FilterList items={listOfMetals} onChange={ ()=>{} }/>);
        const filterInput = screen.getByPlaceholderText(/Filter/i);
        fireEvent.change(filterInput, {target: {value: 'mi'}});
        expectOnlyItems([/Aluminium/i, /Chromium/i]);
      });
    });

    describe('selection', () => {
      it('should select unselected items that are clicked', () => {
        render(<FilterList items={listOfMetals} onChange={ ()=>{} }/>);
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const potassium = within(list).getByText(/Potassium/i);
        fireEvent.click(potassium);
        expect(potassium).toHaveClass('selected');
      });

      it('should unselect selected items that are clicked', () => {
        render(<FilterList items={listOfMetals} onChange={ ()=>{} }/>);
        const list = screen.getByRole('list', {name: /Filtered list/i});
        const beryllium = within(list).getByText(/Beryllium/i);
        fireEvent.click(beryllium); // select Beryllium
        fireEvent.click(beryllium); // unselect Beryllium
        expect(beryllium).not.toHaveClass('selected');
      });
    });
  });
});

function expectOnlyItems(textMatches) {
  const list = screen.getByRole('list', {name: /Filtered list/i});
  const listItems = queryAllByRole(list, 'listitem');
  expect(listItems.length).toBe(textMatches.length);
  for (const tm of textMatches) {
    getByText(list, tm);
  }
}
```


###### `useEffect`

Requires waiting for changes to take effect, e.g. with a promise from an API call.
When working with an asynchronous API call, the API needs to be mocked with `jest.mock()`.


Interaction Tests

The following example shows how to mock an API:
```ts
// api.ts
export const planets = ['Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']

export function getPlanets(): Promise<string[]> {
    return Promise.resolve(planets);
}
```

```tsx
// interactions.test.tsx
import * as api from '../api';

const listOfExoplanets = ['Kepler-22b', 'Kepler-452b', 'TrES-2b'];

jest.mock('../api');
api.getPlanets.mockResolvedValue(listOfExoplanets);
```
All the following tests will now use the mock when an API call happens.

Next, the tests should have functions that wait, so the API promise is resolved when the asserts happen, for example:
```tsx
const user = userEvent.setup();
render(<FilterList onChange={ ()=>{} }/>);

// user.type is an async functions, so by the time it is resolved,
// the API call will be resolved as well.
const filterInput = screen.getByPlaceholderText(/Filter/i);
await user.type(filterInput, '5');
expectOnlyItems([/Kepler-452b/i, /Gliese 504 b/i]);
```
or:
```tsx
// Waits for up to 1s until it finds a Text element with the value "TrES"
const tres = await within(list).findByText(/TrES/i);
// The user.click waits till the previous line has resolved.
await user.click(tres);
```


Rendering Tests

Rendering test stay synchronous when the components are made pure - no use of `useState` or `useEffect` in them.

```tsx
// rendering.test.tsx
import {planets} from '../api'

export const defaultProps = {
  filter: '',
  selectedItems: [],
  onFilterChange: ()=>{},
  onItemSelection: ()=>{},
};

describe('filtered', () => {
      it("should render no items when filter is `xqz`", () => {
        const props = {
          ...defaultProps,
          items: planets,
          filter: 'xqz',
        }
        render(<FilterListPure { ...props } />)

        const list = screen.getByRole('list', {name: /Filtered list/i});
        const listItems = queryAllByRole(list, 'listitem');
        expect(listItems).toHaveLength(0);;
      });
 })
```

##### Testing Integrated Components and Feature Testing

Testing at the application user level.

Integrated components are components within other components within other components …

When testing integration of external systems, like writing to a file, or accessing a database.

Testing a tree of components from an outermost component.
Steps:
- Assemble the components into a tree.
- Write tests against the outermost component.

![[Pasted image 20231105211735.png]]

Feature Testing is Behaviour-driven development that isn't interested in the implementation. You start with writing behaviour tests, and after that write the specific implementation.
This also provides documentation on how the application should behave through the tests, and has to stay correct. Otherwise, the tests fail. Can be very useful with ageing applications.

![[Pasted image 20231105213212.png]]

Example:
```tsx
describe('Metals page', () => {
    it('should initially show no metals', () => {
        render(<Metals/>);
        const container = screen.getByRole(
	        'generic', { name: /Metals display/i });
        const metals = within(container).queryAllByRole('
	        generic', { name: /Metal/i });
        expect(metals.length).toBe(0);
    });

    it('should show one selected metal', () => {
        render(<Metals/>);
        // select a metal
        const list = screen.getByRole('list', { name: /Filtered list/i });
        const potassium = within(list).getByText(/Potassium/i);
        fireEvent.click(potassium);
        const container = screen.getByRole(
	        'generic', { name: /Metals display/i });
        const metals = within(container).queryAllByRole(
	        'generic', { name: /Metal/i });
        expect(metals.length).toBe(1);
        within(container).getByText(/Potassium/i);
    });

    it('should show multiple selected metals', () => {
        const metalsToSelect = [
	        /Beryllium/i, /Calcium/i, /Scandium/i, /Vanadium/i];
        render(<Metals/>);
        const list = screen.getByRole('list', {name: /Filtered list/i});
        for (const metal of metalsToSelect) {
            fireEvent.click(within(list).getByText(metal));
        }
        const container = screen.getByRole(
	        'generic', { name: /Metals display/i });
        const metals = within(container).queryAllByRole(
	        'generic', { name: /Metal/i });
        expect(metals.length).toBe(metalsToSelect.length);
        for (const metal of metalsToSelect) {
            within(container).getByText(metal);
        }
    });
});
```

#### Q&A

Q: Why would, or wouldn't, you test implementation details?
A: You would, when rendering pure stateless components, to make sure what is rendered is expected with the given props. Not for stateful components. With the latter, we only want to test interactions.

*Implementation details* are things which users of your code will not typically use, see, or even know about.

Q: How do you interact with the component during testing.
A: By using an Interactions API, like `user-event` or `fireEvent`, which have methods to mock user behaviour like clocking on a certain element.

---

## Integration Test


---

## Acceptance Tests (Testable Architecture)

![[Pasted image 20231016200928.png]]
![[Pasted image 20231016201036.png]]
![[Pasted image 20231016201020.png]]

![[Pasted image 20231016201509.png]]

### Example

![[Pasted image 20231016201638.png]]

#### SpecFlow

Test written in business language, which SpecFlow generates code from.

![[Pasted image 20231016202943.png]]
![[Pasted image 20231016203042.png]]


---

# Outside-In Test-Driven Development

## Courses

- [Outside-In Test-Driven Development by Mark Seemann](https://app.pluralsight.com/course-player?clipId=fcb9aac1-0452-45cb-9fc2-ae610c5b45e6)

## Introduction

- Start testing at the boundaries of the system.
- YAGNI Principle = You Aren't Gonna Need It.
- Better business value.

![[Pasted image 20231017223504.png]]

High-level perspective of Outside-In Testing:
![[Pasted image 20231017224006.png]]
![[Pasted image 20231017224020.png]]
![[Pasted image 20231017224042.png]]

SUT = System Under Test

Write just enough code in the SUT to make the test you are testing pass.
Only test against external boundaries of the SUT, illustrated by the small box against the SUT in the diagram above.

![[Pasted image 20231017224558.png]]

![[Pasted image 20231017224727.png]]

![[Pasted image 20231018104404.png]]
![[Pasted image 20231018104454.png]]

---

## Walking Skeleton

>"an implementation of the thinnest possible slice of real functionality that we can automatically build, deploy, and test end-to-end"

This can be used to drive:
- Infrastructure
- Process

Implementation order:
1. GET request with HTTP respons status code 200 OK.
	1. Write Test
	2. Implement ApiController to handle GET
2. POST request with HTTP respons status code 200 OK.
3. Do POST followed by GET to test if they both actually work.

Work with lists to fake a Database, but allows to test basic functionality.

---

## Spiking

Spiking is going through the SUT from an external boundary all the way to an internal boundary, for example, from an API endpoint, to a persistent storage like a database.

### FIRST

FIRST principle on writing tests:
- Fast
- Isolated
- Repeatable
- Self-validating
- Timely

### Four-Phase Test

The AAA (Arrange-Act-Assert) test pattern is a super set of the Four-Phase Test, but leaving out the 4th, because you don't have to write it.

The Four-Phase Test:
1. Ficture Setup (Arrange)
2. Exercise SUT (Act)
3. Result Verification (Assert)
4. Fixture Teardown (Dispose of the client)

### Backdoor Manipulation

![[Pasted image 20231018100134.png]]

---

## Triangulation

![[Pasted image 20231018102743.png]]

Triangulation works by applying a *Stimulus* to the SUT, and then measuring the *Response*.
The *Response* can be a *Return Value*, or an *Observable State* of the SUT. 
The *Direct Output* is what you measure/assert at the end of the test.

![[Pasted image 20231018100414.png]]

The term *Triangulation* comes from geometry, where you can triangulate a position by measuering the distance to atleast two fixed reference points.
In tests, the tests are the fixed reference points, and the SUT is what we want to measure, or sample.

![[Pasted image 20231018101240.png]]
![[Pasted image 20231018101219.png]]

### When To Use

![[Pasted image 20231018100344.png]]

### Devil's Advocate and Ping Pong Techniques

Implement code as naively as possible.
To combat the tendency to keep implementing new features without writing new tests.
De Devil's Advocate technique helps focus tests on their essence.

Gollum Style when developing on your own.

![[Pasted image 20231018102138.png]]

![[Pasted image 20231018102302.png]]
![[Pasted image 20231018102354.png]]

---

## Behavior Verification (Mockist)

*Counterpart to Triangulation.*

![[Pasted image 20231018104827.png]]

![[Pasted image 20231018103052.png]]

### Cyclomatic Complexity

Counts the number of paths through the code.
Meaning +1 for each `if, else, case, for, foreach, do, while, catch`.
For each count there needs to be a test, to make sure the path works as expected.

### Code Coverage

Can be interesting to watch the trend of Code Coverage, for example, if it keeps decreasing, you want to look into it. But it is not a measure of quality.

![[Pasted image 20231018103753.png]]

### Componentization

Less testing is necessary if splitting up functionality into different classes.

![[Pasted image 20231018104030.png]]

### Stubs and Mocks

![[Pasted image 20231018104230.png]]



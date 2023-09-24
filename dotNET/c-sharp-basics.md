---
language: c#
---
# C\# Basics

## Courses and References

- [Zie Scherp Scherper by Tim Dams, AP Hogeschool Antwerpen](https://apwt.gitbook.io/zie-scherp-scherper/)
- [The Ultimate Cheat Sheet for C# by Christian Schou](https://blog.christian-schou.dk/csharp-cheat-sheet/)
- [Properly Formatting IF Statements in Your C# Code by Christian Schou](https://blog.christian-schou.dk/formatting-if-statements-in-csharp/)
- [C# 9: Pattern Matching in Switch Expressions by Thomas Claudius Huber](https://www.thomasclaudiushuber.com/2021/02/25/c-9-0-pattern-matching-in-switch-expressions/)
- [C# Foreach: what it is, How it works, Syntax and Example Code by Ravikiran A S](https://www.simplilearn.com/tutorials/asp-dot-net-tutorial/csharp-foreach)

---

## Introduction

**Main characteristics** of C#:

-   **Multithreading.** C# allows for simultaneous execution of multiple processes in an application, which helps you maximize the usage of CPU resources.
-   **Object-oriented programming.** C# supports the main principles of OOP: inheritance, abstraction, encapsulation, and polymorphism.
-   **Type****-safety.** C# is a type-safe language, which means that it ensures the internal consistency of types due to the usage of protocols for the interaction between types.
-   **Auto-garbage collection.** A significant feature of the C# language is automatic garbage collection, meaning that you will not have to worry about freeing memory, unlike in C++.
[Source](https://www.sam-solutions.com/blog/dot-net-vs-c/)

---


## Glossary


---

## Naming Conventions

[Best Practices for C# - Coding Standards by Christian Schou](https://blog.christian-schou.dk/best-practices-csharp/)

### Class Names

- PascalCasing
- Name that is descriptive and easy to read.
- Should be nouns or noun phrases, no verbs.
- Avoid using abbreviations, unless they are widely accepted and understood.

Examples: `CustomerOrder`, `ShoppingCart`, `HttpRequest`, `XmlDocument`.

---


## Datatypes

`datatype identifier = literal;` 
`datatype identifier1, identifier2, identifier3;`

Literal is a value explicitly set in the code. Not through calculation or user input.
### Primitive Datatypes

- Integers: `sbyte, byte, short, ushort, int, uint, long, ulong`
- Decimals: `double, float, decimal`
- Text: `char, string`
- Booleans: `bool`
- Enums 

s = signed
u = unsigned

To get the range of a datatype in code, use `datatype.MinValue` and `datatype.MaxValue`.
#### Integers

| Type     | Memory  | Range                                                   | Literal | Default Value |
| -------- | ------- | ------------------------------------------------------- | ------- | --- |
| `sbyte`  | 8 bits  | -128 to 127                                             |     | 0 |
| `byte`   | 8 bits  | 0 to 255                                                |      | 0 |
| `short`  | 16 bits | -32 768 to 32 767                                       |      | 0 |
| `ushort` | 16 bits | 0 to 65535                                              |     | 0 |
| `int`    | 32 bits | -2 147 483 648 to 2 147 483 647                         |   | 0 |
| `uint`   | 32 bits | 0 to 4 294 967 295                                      | U or u, e.g.: 125u        | 0 |
| `long`   | 64 bits | -9 223 372 036 854 775 808 to 9 223 372 036 854 775 807 | L or l, e.g.: 125l        | 0 |
| `ulong`  | 64 bits | 0 to 18 446 744 073 709 551 615                         | UL or ul, e.g.: 125ul        | 0 |
| `char`   | 16 bits | 0 to 65 535                                             |         | \0 |

##### Hexadecimal or Binary Notation

Hex value starts with `0x` or `0X`
```c#
int age = 0x0024; //36
byte byteValue = 0x00C9; //201
```

Binary starts with `0b` or `0B`.
```c#
int age = 0b001001000; //72
int ageWithSeperators = 0b0001_0110_0011_0100_0010 // _ as seperator
byte byteValue = 0b‭00100100‬1;
```
#### Decimals

| Type  | Memory | Range | Precision     | Literal | Default Value |
| --------- | ------------ | ---------- | ---------------- | --- | --- |
| `float`   | 32 bits  | average  | ~6-9 digits      | F or f, e.g.: 12.5f | 0.0 |
| `double`  | 64 bits      | **largest** | ~15-17 digits    |     | 0.0 |
| `decimal` | 128 bits     | least     | 28-29 digits | M or m, e.g.: 12.5m | 0.0 |

#### Booleans

| Type | Memory | Range | Literal | Default Value |
| ---- | ------ | ----- | ------- | ------------- |
| bool     | 1 bit       | true or false       |         | false              |

#### Text

| Type | Memory | Range | Example | Default Value |
| ---- | ------ | ----- | ------- | ------------- |
| char | 16 bits       | 0 to 65 535      | `char letter = 'b'`        | \0              |
| string     |        |       | `string name = "Bavo"`         | "" or String.Empty              |

##### Concatenation

*Plus-operator*: `"Some text" + stringVar + "some more text" + intVar + "end of the text."`  

*Interpolation*: `$"Some text {stringVar} some more text {intVar + literal} end of the text."`

*Multi-line* (also works together with $): 
```c#
@" 
text
more text
and moooooore text.
";
```

##### Number Formatting in Strings

```c#
double number = 12.345;
Console.WriteLine($"{number:F2}");

// Output float with 2 decimals: 12.35
```

F# = float with number of significant digits, e.g.: `12.345` becomes `12.35`.
D# = integer with number of digits, e.g.: `123` becomes `00123`.
E# = scientific notation with number of precision, e.g.: `12000000` becomes `1,20E+007`.
C = currency, e.g.: `12,34` becomes `$12,34`.

##### Escape Characters

- `\'`
- `\"`
- `\\` one backslash, two backslashes? `"\\\\"`
- `\n` newline
- `\t` horizontal tab
- `\a` a computer beep (depends on computer settings).
- `\uxxxx` a `char` with hexidecimal UNICODE value where `xxxx`.

##### UNICODE

Three ways to write Unicode characters:

```c#
Console.OutputEncoding = System.Text.Encoding.UTF8;

char copyright = "©" // copy-paste
copyright = (char)0x00A9; // casting with hex code
copyright = "\u00A9"; // escape character with hex code
```


### Enumerations `enum`

A datatype you can create yourself with a custom list names and values.

Provides:
1. Better readable code.
2. Less prone to errors.
3. Great for coding finite state machines (enum for states in a switch statement).
4. Faster coding with better help from IntelliSense in Visual Studio.

Syntax datatype creation, outside `Main`: `enum EnumName { Name1=1, Name2 };

By default, the values are numbered integers starting from 0 and counting up.
By setting the first value, you can change the starting value of the up counting.
You can set a custom value for every name.

	Visual Studio houdt van enums (ik ook) en zal je helpen bij het schrijven van een `switch` indien je test-variabele een enum-type bevat. Hoe?
	- Schrijf `switch` en druk op 2 maal op tab. Normaal verschijnt er nu een "prefab" switch structuur met een test-waarde genaamd `switch_on` die een gele achtergrond heeft
	- Overschrijf `switch_on` met de variabele die je wilt testen (bv. `dagKeuze`)
	- Klik nu met de muis eender waar binnen de accolades van de `switch`

#### Parsing `enum`

Using *generics* `<Type>` user input can be cast to the corresponding enum value.
Optionally, there's a boolean parameter to make the input case-sensitive.

Syntax: `EnumName userInput = Enum.Parse<EnumName>(Console.ReadLine(), true);`


### [Environment Library](https://learn.microsoft.com/nl-be/dotnet/api/system.environment?view=net-7.0)

```c#
bool is64bit = Environment.Is64BitOperatingSystem;
string pcname = Environment.MachineName;
int proccount = Environment.ProcessorCount;
string username = Environment.UserName;
long memory = Environment.WorkingSet; // Memory allocated by the OS for the app.
```

Exit program: `Environment.Exit(0);`


### Casting, Conversion, and Parsing

#### Casting

*Casting works in a lot of different programming languages, but is the old way of doing it in .NET where [Conversion](#Conversion) is more desired.*

Casting is necessary when *narrowing* data. Meaning, there's a loss of data when converting to another datatype. For example, double to int.
It can also be used to tell the compiler that in a calculation, the result needs to be a certain datatype. For example, when dividing an integer and the result is a decimal.

*Converting to and from strings is not done with casting, but with converting or parsing.*

Syntax: `(datatypeToCastTo)literalOrVarToCast;`

*Example Narrowing:*
```c#
int castedNumber = (int)3.5;

double decimalNumber = 13.8;
int decimalCastedToInteger = (int)decimalNumber;
```

*Example Calculation:*
```c#
int tempYesterday = 20;
int tempToday = 25;

double tempMedian = (tempYesterday + tempToday) / 2;
// tempMedian = 22.0

double tempMedian = ((double)tempYesterday + (double)tempToday) / 2;
// tempGemiddeld = 22.5

// Having only one of the values in this calculation be a double will give a double as result.
```

#### Conversion

Using the [Convert](https://learn.microsoft.com/en-us/dotnet/api/system.convert?view=net-7.0&redirectedfrom=MSDN) library of .NET.
See documentation for all the available methods.

*Example:*
```c#
int number = Convert.ToInt32(3.2); //double to int
double decimalNumber = Convert.ToDouble(5); //int to double
bool isTrue = Convert.ToBoolean(1); //int to bool, 0 = false, everything else true
int age = Convert.ToInt32("19"); //string to int
int otherAge = Convert.ToInt32(decimalNumber); //double to int
```

#### Parsing

Parsing will largely be used to convert a `string` into another datatype. Each build in datatype in C# has a `.Pasre()` method. Underlying, however, the `Convert.To...` will almost always be used.

##### `.Parse()`

Only use `.Parse()` when you know a string is meant to be converted into a specific datatype.

*Example:*
```c#
int numVal = Int32.Parse("-105"); // Expects a Int32, can't work with anything else.
Console.WriteLine(numVal);
```

##### [`.TryParse()`](https://learn.microsoft.com/en-us/dotnet/api/system.int32.tryparse?view=net-7.0)

Use `.TryParse()` when getting input from the user, for example through `Console.ReadLine`, and you don't know for sure if it is going to be a number or a string. A boolean as return value will indicate if the parsing succeeded or not.

### Math-Library

To perform mathematical calculation effectively, use the Math-library.

- `Math.Max` returns the largest of two numbers.
- `Math.Min` returns the smallest of two numbers.
- `Math.Pow(number, power)`
- `Math.Sqrt` to calculate the square root of a number.
- `Math.PI` for the number π
- `Math.Sin` sinus in radials (not degrees!).

#### Rounding

`Math.Round` performs Banker's Rounding, meaning rounding to the closest ***even*** number.
You can control the rounding by adding a rounding parameter:

```c#
Math.Round(numberToRound, MidpointRounding.AwayFromZero); // Rounds up

Math.Round(numberToRound, MidpointRounding.ToZero); // Rounds down
```

### Random

Create a random generator object once and use it to generate random numbers with the `.Next()` method for an integer, or `.NextDouble()` for a decimal.

#### `.Next()`

`.Next(min, max)` returns an integer from `min` to, but not including, `max`.

```c#
Random randomGenerator = new Random(); // You can also give a seed, eg.: Random(seed)
int randomNumber = randomGenerator.Next();

int a = someGenerator.Next(0,10); // Number between 0 and 10: 0, 1, 2, 3, 4, 5, 6, 7, 8, or 9, not including 10.
```

#### `.NextDouble()`

`.NextDouble()` generates a decimal between `0.0` and `1.0`.
To change the range, you can add a base value and a multiplier as follows:

`baseValueDouble + (randomGenerator.NextDouble() * multiplierValueDouble);`

*Example:*
```c#
int seed = 100;
Random randomGenerator = new Random(seed);

double decimal1 = randomGenerator.NextDouble() * 10.0; // Between 0.0 and 10.0

double decimal2 = 5.0 + (randomGenerator.NextDouble() * 7.5); // 5.0 and 12.5
// Random decimal between 0.0 and 1.0 is first multiplied to extend the range to 7.5 and then shifting it by 5.0 => between (0.0 + 5.0 = 5.0) and (7.5 + 5.0 = 12.5).
```

---


## Decisions

### Boolean Expressions
#### Relational Operators

```c#
>   // Larger than
<   // Smaller than
==  // Equals
!=  // Does not equal
>=  // Larger or equal to
<=  // Smaller or equal to
```

#### Logic Operators

```c#
&&  // AND
||  // OR
!   // NOT
```

#### Ternary / Conditional Operators

Ternary operators, also known as conditional operators, are a concise way to write simple `if-else` statements in a single line of code. They can be useful when you need to assign a value to a variable based on a condition. Proper formatting of ternary operators is essential to ensure that the code remains readable and understandable.

Syntax: `variable = (condition) ? valueIfTrue : valueIfFalse;`

The `condition` is a boolean expression that is evaluated, and if it is true, `valueIfTrue` is assigned to the `variable`; otherwise, `valueIfFalse` is assigned.

*Example:*
```c#
int age = 25;
string result = (age >= 18) ? "You are an adult" : "You are a minor";
Console.WriteLine(result);
```

Ternary operators can be a useful tool for writing concise and readable code in certain scenarios. However, it's important to use them judiciously and consider the readability and maintainability of the code, especially when dealing with complex conditions or multiple statements.
#### If, else if, and else-statement

The less boolean expressions the code has to go through, the more performant, so place the most likely case at the top.

```c#
if (boolean expression) // Also called the condition
{
	// If true do this code of multiple lines
	// ...
}
else if (boolean expression)
{
	if (boolean expression) // Nesting
	// code ...
}
else
{
	// code ...
}
```

Proper placement of parentheses, braces, and indentation is essential for a well-formatted if statement in C#. Here are some best practices:

1. **Parentheses**: The condition should be enclosed in parentheses `( )` immediately following the `if` keyword.
2. **Braces**: The code block to be executed should be enclosed in curly braces `{ }`. Even if the code block has only one statement, it is recommended to use braces to avoid potential issues with code maintenance and readability.
3. **Indentation**: The code block inside the if statement should be indented with consistent spacing to visually separate it from the surrounding code.

##### Keep if statements simple and concise

If statements should be kept simple and concise to improve the readability of the code. Avoid using complex conditions or multiple nested if statements, as they can make the code difficult to understand and maintain. If the condition or logic becomes too complex, consider refactoring the code into smaller, more manageable pieces.

```csharp
// Bad example
if (a > b && c < d || e == f || !(g <= h))
{
    // ...
}

// Good example
bool condition1 = a > b;
bool condition2 = c < d;
bool condition3 = e == f;
bool condition4 = !(g <= h);

if (condition1 && condition2 || condition3 || condition4)
{
    // ...
}
```

##### Comment complex or non-obvious conditions

If you have complex or non-obvious conditions in your if statements, it's a good practice to add comments to explain the logic. This can help other developers, including your future self, to understand the purpose and meaning of the condition.

```csharp
// Bad example
if (isAdministrator && (isOwner || hasPermission) && !isBlocked)
{
    // ...
}

// Good example
// Check if user is an administrator and has the necessary permissions
if (isAdministrator && (isOwner || hasPermission) && !isBlocked)
{
    // ...
}
```


#### Switch Case Statement

To implement a state machine, or go over different states of a single value or variable, the switch case is more readable than an if/else statement.

Syntax:
```c#
switch (value)
{
    case constant: // Case values need to be constants, not variables.
        statements
        break;
    case constant:
        statements
    case constant: // Fallthrough case. Previous has no "break;", so it goes on.
        statements
        break;
    default:
        statements
        break;
}
```

##### [Pattern Matching in Switch Expressions](https://www.thomasclaudiushuber.com/2021/02/25/c-9-0-pattern-matching-in-switch-expressions/)

###### Type Patterns

C# 7.0 introduced the support for type patterns in `switch` statements. You can switch by any type, and you can use patterns in your `switch` statement.

*Example:*
```c#
object obj = new Developer { FirstName = "Thomas", YearOfBirth = 1980 };

string favoriteTask;

switch (obj) // Since C# 7.0, any type is supported here
{
	case Developer _: // Type pattern with discard (_)
		favoriteTask = "Write code."; 
		break; 
	case Manager manager: 
		favoriteTask = $"{dev.FirstName} sets up meetings.";
		break; 
	case null: // The null pattern 
		favoriteTask = "Look into the void."; 
		break; 
	default: 
		favoriteTask = "Listen to music."; 
		break; }
```

	I switch by an `object` variable. 
	Then I use the type pattern to check if the object is a `Developer` or a `Manager`. 
	When you don’t need for example the `Developer` object to be stored in a variable, you use a discard, which is an underscore.

###### When condition

Acts like an if-statement within a case.

*Example:*
```c#
case Developer dev when dev.YearOfBirth >= 1980 && dev.YearOfBirth <= 1989:
// Checks if the objects is a Developer AND if they are born in the 80's.
	favoriteTask = $"{dev.FirstName} listens to heavy metal while coding"; 
	break;
```

###### Switch Expressions

C# 8.0 introduced `switch` expressions.
A `case` in a `switch` expression is a **_switch expression arm_**.
Allows trailing commas.

*Example:*
```c#
string favoriteTask = developer.FirstName switch // does not work with null
{ 
	"Julia" => "Writing code", // This is the first switch expression arm 
	"Thomas" => "Writing this blog post", 
	_ => "Watching TV", // default expression arm, trailing comma allowed
};
```

###### Property Patterns

Same Switch Expression as the above example, but with Property Patterns:
```c#
string favoriteTask = developer switch 
{ 
	{ FirstName: "Julia" } => "Writing code", 
	{ FirstName: "Thomas" } => "Writing this blog post", 
	_ => "Watching TV", 
};
```

Instead of using `when` to check a property of the object, you can do this with a property pattern:
```c#
string favoriteTask = obj switch 
{ 
	Developer { YearOfBirth: 1980 } dev => $"{dev.FirstName} listens to metal", 
	Developer dev => $"{dev.FirstName} writes code", 
	Manager _ => "Create meetings", 
	_ => "Do what objects do", 
};
```

###### Relational Patterns and Pattern Combinators

Introduced in C# 9, Relational Patterns and Pattern Combinators can be used with `is` and `switch` expressions.

Relational Patterns: `>`, `>=`, `<`, and `<=`.
Pattern Combinators: `and` and `or`.

*Example with `when is`:*
```c#
string favoriteTask = obj switch 
{ 
	Developer dev when dev.YearOfBirth is >= 1980 and <= 1989 
		=> $"{dev.FirstName} listens to metal",
	Manager => "Create meetings", // discard "_" no longer necessary in C# 9.
	_ => "Dance like no one is watching",
};
```

*Example with Property Pattern instead of `when`:*
```c#
string favoriteTask = obj switch 
{ 
	Developer { YearOfBirth: >= 1980 and <= 1989 } dev 
		=> $"{dev.FirstName} listens to metal", 
	_ => "Dance like no one is watching",
};
```

You can also use Property Patterns without Type Patterns, and ***nest*** Property Patterns:
```c#
string favoriteTask = dev switch 
{ 
	{ Manager: { YearOfBirth: 1980 } } => "Manager listens to heavy metal", 
	not null => $"{dev.FirstName} writes code", 
	_ => "Look into the void", 
};
```

Simple type variables (not objects), don't need the curly braces `{}`. *Example:*
```c#
int yearOfBirth = 1980; 
string favoriteTask = yearOfBirth switch 
{ 
	1984 => "Read George Orwell's book", // Constant pattern 
	>= 1980 and <= 1989 => "Listen to heavy metal", // Combined relational patterns 
	> 1989 => "Write emails like everyone is watching", // Relational pattern 
	_ => "Dance like no one is watching", // <- This comma here is optional 
};
```

---


## [Loops or Iteration Statements](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/iteration-statements)

- `while` condition is true.
- `do while` do at least once, and while the condition is true.
- `for` a specific amount of times, loop through something, e.g. an array.
- `foreach` for looping through objects.

### `while`

Syntax:
```c#
while (conditie) 
{
  // Code executed while the condition is true.
}
```

Diagram:
![[Pasted image 20230924135059.png]]

### `do while`

Syntax:
```c#
do{
     // Code executed once, and again while the condition is true.
} while (conditie);
```

Diagram:
![[Pasted image 20230924135241.png]]

### `for`

Syntax:
```c#
for (setup; finish test; update)
{
    // Code executed as long as the finish test is true.
}
```

Diagram:
![[Pasted image 20230924135654.png]]

*Example:*
```c#
// In Visual Studio get template by typing "for" + tab + tab.
for (int i = 0; i < 11; i += 2) // i stands for increment
{
    Console.WriteLine(i);
}
```

Avoid using the keywords `break`, `continue` or `goto`. They often lead to unwanted behaviour. Most times, better boolean expressions can give the desired outcome.

### `foreach`

Loops through all elements in a given iterable item, like an array, List\<T\> collection, IEnumerable interface, collections of objects, or a Dictionary (KeyValuePair datatype, representing a pair of objects).

Limitations.

1. They don’t keep track of the index of the item.
2. They cannot iterate backwards. The loop can only go forward in one step. 
3. If you wish to modify the array, the foreach loop isn’t the most suitable option.
4. The foreach loop cannot execute two-decision statements at once.

Syntax:
```c#
foreach (datatype elementName in iterableItem)
{
	// Do something with the element
}
```

Diagram:
![[Pasted image 20230924141233.png]]
[*Source*](https://www.simplilearn.com/tutorials/asp-dot-net-tutorial/csharp-foreach)

*Example:*
```c#
var fibNumbers = new List<int> { 0, 1, 1, 2, 3, 5, 8, 13 };

foreach (int element in fibNumbers)
{
    Console.Write($"{element} ");
}
// Output:
// 0 1 1 2 3 5 8 13
```

*Asynchronous example:*
```c#
await foreach (var item in GenerateSequenceAsync())
{
    Console.WriteLine(item);
}
```

Use the [`var` keyword](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/declarations#implicitly-typed-local-variables) to let the compiler infer the type of the iteration variable.

*Dictionary example, using the **KeyValuePair<TKey, TValue>** structure to access each key-value pair in the dictionary:*
```c#
Dictionary<string, int> ages = new Dictionary<string, int>
{
    { "Alex", 25 },
    { "Hannah", 20 },
    { "Maeve", 21 }
};

foreach (KeyValuePair<string, int> pair in ages)
{
    Console.WriteLine("{0} is {1} years old.", pair.Key, pair.Value);
}
```

### Comparing `for` and `foreach`

| `for`                                                                             | `foreach`                                                                               |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Executes a statement or a block of statements until the given condition is false. | It executes a statement or a block of statements for each element present in the array. |
| Works on maximum and minimum limits                                               | Does not require defining limits.                                                       |
| We can iterate the array in both forward and backward directions,                     | Only forward.                                                                           |
| ``for`` loop only has three variable declarations.                                    | ``foreach`` loop has five variable declarations.                                            |
| Uses loop counter variable.                                                       | Only needs a variable declared with the same datatype as the base of the collection.   |
| No creation of array copies.                                                      | Creates an array copy for the operation.                                                |

---


## Methods

Syntax:
```c#
/// <summary>
/// Give a summary of the functioning of the method.
/// </summary>
/// <param name="parameterIdentifier">Give info in this parameter</param>
/// <returns></returns>
static returntype MethodeName(datatype parameterIdentifier = defaultValue) // Parameters are optional and don't need a default value. Also called formal parameters.
{
	#region // Do add collapse/expand capability in Visual Studio
    //code
    #endregion
    return result; // not when returntype is void
}
```

Returntype: `void` or any datatype or object.

Parameters can be given:
- by value: a copy is made of the current value.
- by reference: the pointer with the address of the actual variable is passed.

Parameters with a default value are optional when calling the method. However, you can only leave them out from back to front. If you leave out one parameter, you can't still add the next one. Unless you make it a named parameter.

*Example:*
```c#
public void IntroduceYourself(string firstName, string lastName = "Doe")
{
    Console.WriteLine("Hello, my name is " + firstName + " " + lastName);
}


IntroduceYourself("John", "Smith"); // Outputs: Hello, my name is John Smith
IntroduceYourself("John");          // Outputs: Hello, my name is John Doe

```

### Named Parameters

By naming the parameters to which you pass values when calling a method, you can make it more readable, and change the order.
When the parameters stay in the correct order, you don't have to name them all.
If you do change the order, you have to name them all.

*Example:*
```c#
IntroduceYourself(lastName: "Swift", firstName: "John");
// Outputs: Hello, my name is John Swift
```
### Overloading

Method overloading, or function overload, is a feature that allows you to define multiple methods with the same name but with a different set of parameters. This allows you to perform different operations using the same method name, making your code more intuitive and easier to use.

*Example:*
```c#
public void DisplayMessage(string message)
{
    Console.WriteLine(message);
}

public void DisplayMessage(string message, string name)
{
    Console.WriteLine(message + ", " + name);
}
```

#### Betterness-rule

The best fitting method is chosen by the provided variables.

|Parametertype|Preference from most preferred to least|
|---|---|
|`byte`|`short, ushort, int, uint, long, ulong, float, double, decimal`|
|`sbyte`|`short, int long, float, double, decimal`|
|`short`|`int, long, float, double, decimal`|
|`ushort`|`int, uint, long, ulong, float, double, decimal`|
|`int`|`long, float, double, decimal`|
|`uint`|`long, ulong, float, double, decimal`|
|`long`|`float, double, decimal`|
|`ulong`|`float, double, decimal`|
|`float`|`double`|
|`char`|`ushort, int, uint, long, ulong, float, double, decimal`|

### Recursion

Call the method within the method itself.

```c#
static int CalculateSumRecursive(int start, int stop)
{
	int sum = start;
	if(start < stop)
	{
		start++;
		return sum += CalculateSumRecursive(start, stop);
	}
	return sum;
}
```

---


## Arrays

Syntax: `datatype[] arrayName = {value1, value2};`

*Example:*
```c#
string[] myColors; // myColors holds the reference
myColors = {"red", "green", "yellow", "orange", "blue"}; // length set to 5.
```

`datatype[] arrayName;` only reserves a reference in memory without a length.
`datatype[] arrayName = new datatype[length];` provides a length so the values are filled with the default values of the chosen datatype.

Once the length of the array is set, it can't change any more.
The array variable works by reference. Meaning, it is a pointer that stores the memory address to the start of the array. The elements of the array are stored by value at the memory address to which the pointer points + their index.
So, if you assign an array to another `array1 = array2` it only copies the address.
To copy the values, use `.Copy` method of the Array library (different with objects!).
### Array accessor

The value in an array can be read/write using the array accessor with the index of the value: `[index]`. Index start counting from `0`.

*Example:*
```c#
myColors[2]; //element with index 2
```

*Looping example:*
```c#
for(int indexCounter = 0; indexCounter < numbers.Length; indexCounter++)
{
    numbers[indexCounter] += 5;
}
```

### System.Array Library

https://apwt.gitbook.io/zie-scherp-scherper/programming-principles/h8-arrays/systemarray
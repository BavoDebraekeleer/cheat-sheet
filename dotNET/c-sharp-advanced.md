---
language: c#
---
# C# Advanced

## Courses

- [Advanced C# Programming Course by @GavinLon and freeCodeCamp.org](https://www.youtube.com/watch?v=YT8s-90oDC0)

## Glossary

[***Extension Methods***](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods) enable you to "add" methods to existing types without creating a new derived type, recompiling, or otherwise modifying the original type. Extension methods are static methods, but they're called as if they were instance methods on the extended type. For client code written in C#, F# and Visual Basic, there's no apparent difference between calling an extension method and the methods defined in a type.
The most common extension methods are the LINQ standard query operators that add query functionality
*Example:*
```c#
namespace ExtensionMethods
{
    public static class MyExtensions
    {
        public static int WordCount(this string str)
        {
            return str.Split(new char[] { ' ', '.', '?' },
                            StringSplitOptions.RemoveEmptyEntries).Length;
        }
    }
}
```

---

[***LINQ = Language Integrated Query***](https://learn.microsoft.com/en-us/dotnet/csharp/linq/) (`using System.Linq`) allows writing queries against collections of strongly typed objects by using language keywords and familiar operators.
*Example 1:*
```c#
// Specify the data source.
int[] scores = { 97, 92, 81, 60 };

// Define the query expression.
IEnumerable<int> scoreQuery =
    from score in scores
    where score > 80
    select score;

// Execute the query.
foreach (int i in scoreQuery)
{
    Console.Write(i + " ");
}

// Output: 97 92 81
```
*Example 2:*
```c#
// employeeList of type IEmployee[]
var employeeNames = employeeList.Where(e => e.Salary > 3000)
	.Select(e => e)
	.Where(d => d.DepartmentID == 2)
	.Select(e => e.EmployeeName);
```

---

***Strongly typed***: the type of variable or object is known and available, for example as an interface.

---

[***Interfaces***](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/interface) are completely “abstract classes”, which can only contain abstract methods and properties (with empty bodies).
It is considered good practice to start with the letter “I” at the beginning of an interface, as it makes it easier for yourself and others to remember that it is an interface and not a class.
By default, members of an interface are `abstract` and `public`.
**Note:** Interfaces can contain properties and methods, but not fields.
*Example:*
```c#
interface IPoint
{
    // Property signatures:
    int X { get; set; }

    int Y { get; set; }

    double Distance { get; }
}

class Point : IPoint
{
    // Constructor:
    public Point(int x, int y)
    {
        X = x;
        Y = y;
    }

    // Property implementation:
    public int X { get; set; }

    public int Y { get; set; }

    // Property implementation
    public double Distance =>
       Math.Sqrt(X * X + Y * Y);
}

class MainClass
{
    static void PrintPoint(IPoint p)
    {
        Console.WriteLine("x={0}, y={1}", p.X, p.Y);
    }

    static void Main()
    {
        IPoint p = new Point(2, 3);
        Console.Write("My Point: ");
        PrintPoint(p);
    }
}
// Output: My Point: x=2, y=3
```

---

[***Delegates***](https://learn.microsoft.com/en-us/dotnet/csharp/delegates-overview) (`using System.Delegate;`) represent references to methods with a particular parameter list and return type.

Delegates provide a _late binding_ mechanism in .NET. “Late Binding” means that you create an algorithm where the caller also supplies at least one method that implements part of the algorithm.
For example, consider sorting a list of stars in an astronomy application. You may choose to sort those stars by their distance from the earth, or the magnitude of the star, or their perceived brightness.
In all those cases, the Sort() method does essentially the same thing: arranges the items in the list based on some comparison. The code that compares two stars is different for each of the sort orderings.

---

[***Lambda expressions***](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-expressions) are a shorter way of representing anonymous methods using special syntax.
[Expression lambda](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-expressions#expression-lambdas) that has an expression as its body: `(input-parameters) => expression`
[Statement lambda](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-expressions#statement-lambdas) that has a statement block as its body: `(input-parameters) => { <sequence-of-statements> }`

The ***Func*** type provides a way to store anonymous methods in a generalized and simple way. `Func<String, String> Selector = Str => Str.Toupper();`

***Anonymous methods*** in C# can be defined using the delegate keyword and can be assigned to a variable of delegate type. They can access variables defined in an outer function, and be passed to a method that accepts the delegate as a parameter.
*Example:*
```c#
public delegate void Print(int value);

static void Main(string[] args)
{
    Print print = delegate(int val) { 
        Console.WriteLine("Inside Anonymous method. Value: {0}", val); 
    };

    print(100);
}
```

---
## Delegates 
*(Course video Part 4 @00:33:17)*

[***Delegates***](https://learn.microsoft.com/en-us/dotnet/csharp/delegates-overview) (`using System.Delegate;`) represent references to methods with a particular parameter list and return type.
It can reference both static and instanced methods.

### Static Methods

Define a delegate's return type and parameters: `delegate returntype DelegateName(parameters);`
Create a new delegate reference: `DelegateName name = new DelegateName(MethodToReference);`
The method pasted to the delegate to reference must have the same return type and parameters.

***Multicast Delegate*** is a delegate referencing multiple methods using the Plus-operator, e.g.: `LogDel multiLogDel = LogTextToScreenDel + LogTextToFileDel;`.

Getting the directory of the application: `AppDomain.CurrentDomain.BaseDirectory`.

*Example:*
```c#
// DelegateBasicExample.cs by Gavin Lon
// https://github.com/GavinLonDigital/DelegateBasicExample

using System;
using System.IO;

namespace DelegateBasicExample
{
    class Program
    {
        delegate void LogDel(string text);
        
        static void Main(string[] args)
        {
            Log log = new Log();

            LogDel LogTextToScreenDel, LogTextToFileDel;

            LogTextToScreenDel = new LogDel(log.LogTextToScreen);

            LogTextToFileDel = new LogDel(log.LogTextToFile);

            LogDel multiLogDel = LogTextToScreenDel + LogTextToFileDel;

            Console.WriteLine("Please enter your name");

            var name = Console.ReadLine();

            LogText(multiLogDel, name);

            Console.ReadKey();
        
        }

        static void LogText(LogDel logDel, string text)
        {
            logDel(text);
        }

    }

    public class Log
    {
        public void LogTextToScreen(string text)
        {
            Console.WriteLine($"{DateTime.Now}: {text}");

        }

        public void LogTextToFile(string text)
        {
            using (StreamWriter sw = new StreamWriter(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Log.txt"), true))
            {
                sw.WriteLine($"{DateTime.Now}: {text}");
            }
        }
    }
}
```

---

*(Course video Part 5 @00:47:47)*

### Databases and Forms

#### Code First Approach

In a code first approach to creating a database, the database and schema are created in the code where it will be accessed.

`Microsoft.EntityFrameworkCore.Sqlite` and `Microsoft.EntityFrameworkCore.Tools` needed to use SQLite in Visual Studio.

`using System.ComponentModel.DataAnnotations.Schema;`

`[DatabaseGenerated(DatabaseGeneratedOptions.Identity)]`

#### [Regex](https://learn.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex?view=net-7.0) [Regular Expression](https://www.geeksforgeeks.org/what-is-regular-expression-in-c-sharp/)

Regular Expression is a pattern which is used to parse and check whether the given input text is matching with the given pattern or not.

[System.Text.RegularExpression](https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions?view=netframework-4.8)

*Example patterns:*
```c#
// CommonRegularExpressionValidationPatterns.cs by Gavin Lon
// https://github.com/GavinLonDigital/ClubMembershipApplication

﻿using System;
using System.Collections.Generic;
using System.Text;

namespace FieldValidatorAPI
{
     public static class CommonRegularExpressionValidationPatterns
     {

        public const string Email_Address_RegEx_Pattern = @"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";

        public const string Uk_PhoneNumber_RegEx_Pattern = @"^\(?(?:(?:0(?:0|11)\)?[\s-]?\(?|\+)44\)?[\s-]?\(?(?:0\)?[\s-]?\(?)?|0)(?:\d{2}\)?[\s-]?\d{4}[\s-]?\d{4}|\d{3}\)?[\s-]?\d{3}[\s-]?\d{3,4}|\d{4}\)?[\s-]?(?:\d{5}|\d{3}[\s-]?\d{3})|\d{5}\)?[\s-]?\d{4,5}|8(?:00[\s-]?11[\s-]?11|45[\s-]?46[\s-]?4\d))(?:(?:[\s-]?(?:x|ext\.?\s?|\#)\d+)?)$";

        public const string Uk_Post_Code_RegEx_Pattern = @"([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})";

        public const string Strong_Password_RegEx_Pattern = @"(?=^.{6,10}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$";
     }
}
```

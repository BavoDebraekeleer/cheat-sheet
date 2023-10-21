# TypeScript Basics

## Courses and References

- [TypeScript documentation](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes-oop.html)
- [Pluralsight: TypeScript 5 Fundamentals by Brice Wilson](https://app.pluralsight.com/library/courses/typescript-5-fundamentals/table-of-contents)
- [TypeScript Playground online editor](https://www.typescriptlang.org/play?ts=5.2.2)
- [Pluralsight: Using Arrays and Collections in Typescript 5 (Arrays, Tuples, Sets, and Maps)](https://app.pluralsight.com/library/courses/typescript-5-arrays-collections/table-of-contents)

---

## Introduction

TypeScript is a sub-set of JavaScript.
Its strong point is strict type checking, like in C#, and unlike JavaScript.

---

## Getting Started

### New Project

1. Install [Node.js](https://nodejs.org/en)
2. Create new project.
3. Install TypeScript locally* for the project: `npm install typescript --save-dev`.

*Has the benefit of having a specific version per project, which you know works.

### Existing Project

1. Install [Node.js](https://nodejs.org/en)
2. Open project.
3. Install dependencies: `npm ci`.
4. Run existing test, making sure they're all green: `npm run test`.

### Automations

TO-DO -> Getting Started with TypeScript

---

## Types

### Primitive Datatypes

- Boolean
- Number
- String
- Array
- Enum

### Additional Built-in Types

- Void – Absence of a type.
- Null
- Undefined
- Never – When the method never returns, e.g. infinite loop, or when throwing an exception.
- Any – Opt out of type checking by the compiler.

### Declaration

- `let`– Recommended way to declare a variable.
- `var`– Not recommended. Works with *hoisting*, meaning the declaration doesn't need to be above any usage.

- `const`– Constant, value never changes.

### Annotations and Inference

An annotation sets the type of a variable during declaration. If another type is being initialized, you'll get a compiler error.
Not needed if you immediately initialize a value during declaration, because the compiler infers the type.
Annotations do make the code easier to read, so is recommended.

*Example:*
```ts
let variableName: string = "I will forever be a string through Annotation.";
let variableName = "I will also forever be a string through Inference.";
```

#### Union Types

Give multiple types as possibility, including null and undefined, bypassing the 
`--strictNullChecks` compiler option.

*Example:*
```ts
let someValue: number | string;
let canBeNull: string | null;

if (typeof(someValue) == string) {
	console.log(someValue); // Here the variable can only be string.
	// The compiler knows this because of the if-statement.
}
```

### String Interpolation

With backticks and `${}` for variables.

*Example:*
```ts
let movieTitle: string = "The Matrix";

console.log(`Movie title: ${movieTitle}`);
```


### Arrays

#### Declaration

```ts
let onlyDeclarationArray: number[];
let strArray1: string[] = ["here", "are", "string"];
let strArray2: Array<string> = ["more", "strings"]; // With Generic
let anyArray: any[] = [42, true, "banana"]; // Mix of types, avoid!
```

Or if you just want to pass an array literal as a parameter, or use the values:
```ts
[1, 2, 3].forEach(number => /* do something */ );
```

### Enums

Enum like in C#, but in JS compiles a function out of it with arrays holding the name as a string and the value as a number.

```ts
enum Name {
	NameOne, // hidden value = 0
	NameTwo, // hidden value = 1
	NameThree = 10
}
```

Example in TypeScript:
```ts
enum ProductCategory {
    Sports,
    HomeGoods
}
let product = ProductCategory.Sports;
```

Compiled to JavaScript:
```js
var ProductCategory;

(function (ProductCategory) {    
	ProductCategory[ProductCategory["Sports"] = 0] = "Sports";    
	ProductCategory[ProductCategory["HomeGoods"] = 1] = "HomeGoods";
}) (ProductCategory || (ProductCategory = {}));

let product = ProductCategory.Sports;
```

### If Statement with Enum

Compare with triple equals sign:
```ts
if (product === ProductCategory.Sports) { }
```

#### Constant Enum

A `const enum` doesn't get compiled into a function, and where it's used only gets the value.

In TypeScript:
```ts
const enum ProductCategory {
	Sports,
	HomeGoods
}
let product = ProductCategory.Sports;
```

Compiled to JavaScript
```js
let product = 0 /* ProductCategory.Sports */;
```

### Get Type

```ts
typeof(variableName); // Returns type
```

---

## Loops and Iteration Statements

### For Loop

```ts
for (let i=1; i<=10; i++) {
	if (i % 2 == 0) {
		console.log(`${i} - even`);
	}
	else {
		console.log(`${i} - odd`);
	}
}
```

### For of and forEach Loops

Two ways to declare and loop over arrays:
```ts
let books: Book[];
...
for (const book of books) {
	/* do something*/
}
```

```ts
let books: Array<Book>;
...
books.forEach(book => /* do something*/ );
```

### While Loop

```ts
let i: number = 1;

while (i <= 10) {
	if (i % 2 == 0) {
		console.log(`${i} - even`);
	}
	else {
		console.log(`${i} - odd`);
	}
	i++;
}
```

### Switch Statement

```ts
let fruit: string = "apple";

switch (fruit) {
	case "orange":
		console.log("Orange")
		break;
	default:
		console.log("Don't know.")
}
```

---

## Functions

*Example:*
```ts
function GetReview(title: string): string | number {
	// return type after parameters with type annotation and union types.
	return "Something";
}
```

Use `--noImplicitAny` compiler options to check if you forgot setting a datatype for the parameters, so they're all explicitly set to a type, even if it is `varName: any`.

### Default and Optional Parameters

Default value with literal, `?` for optional param without default value:
```ts
function GetReview(title: string = "Default", optionalYear?: number): string {
	// The ? indicates an optional parameter. Only after required ones.
	return "Something";
}
```

Expression as default value:
```ts
function GetBookByTitle(title: string = GetMostPopulareBook()): string { }
```

### Rest Parameters

Collect a group of parameters into a single array with ellipsis prefix `...` on last param:
```ts
function GetBooksReadForCust(name: string, ...bookIDs: number[]) { }

let books = GetBooksReadForCust("Leigh", 2, 5, 20); // These numbers all get stored in the bookID array.
```

### Arrow Function

Arrow function are typically used to pass an anonymous function to another function. Traditional functions are still easier to read, and recommended when used multiple times.

Syntax: `variable = parameters => body` or `variable = (parameters) => { body }`

Single line body arrow function, without `{ }`, have an implicit return statement:
```ts
let squareit = x => x * x; // Arrow function
let result = squareit(4); // Usage, result = 16

let adder = (a, b) => a + b;
let sum = adder(2, 3); // 5

let greeting = () => console.log("Hello World!");
greeting();
```

Multi line arrow function as parameter:
```ts
let scores: number[] = [70, 125, 85, 110];
let highScores: number[];
highScores = scores.filter((element, index, array) => {
	if (element > 100) {
		return true;
	}
})
```
*Executes the arrow function for each element in the original array.*

#### Traditional Function to Arrow Function

Traditional Function:
```ts
function LogMessage(message: string): void {
	console.log(message)
}
```

Transformation:
1. Variable instead of `function name` + arrow before the body:
```ts
let LogMessage = (message: string): void => {
	console.log(message)
}
```

2. Single line body, so `{ }` can go:
```ts
let LogMessage = (message: string): void => console.log(message)
```

3. Return type can be inferred:
```ts
let LogMessage = (message: string) => console.log(message)
```


### Function Overloading

To implement function overloading, you need to provide TypeScript with type checking.
You do this with Overload Signatures and `if(typeof())` statements.

1. Overload Signatures:
```ts
function GetTitles(author: string): string[];
function GetTitles(available: boolean): string[];
```

2. Implementation with type `any`:
```ts
function GetTitles(bookProperty: any): string[] { }
```

3. Type checking in the body, on the different parameter types:
```ts
function GetTitles(bookProperty: any): string[] { 
	if (typeof bookProperty == 'string') { }
	else if (typeof bookProperty == 'boolean') { }
	return foundTitles;
}
```

OR
1. Overload Signatures:
```ts
function GetTitles(author: string): string[];
function GetTitles(author: string, available: boolean): string[];
```

2. Implementation with optional parameter:
```ts
function GetTitles(author: string, available?: boolean): string[] { }
```

3. Type checking in the body, if optional parameter is undefined or not:
```ts
function GetTitles(bookProperty: any): string[] { 
	if (available !== 'undefined') { }
	else { }
	return foundTitles;
}
```


### Function Types

Type definition for a function, not an actual function. Not the same as an arrow function.

```ts
let releaseFunction: (someYear: number) => string; // string is the return type.
```

Usage:
```ts
function ReleaseMessage(year: number): string { // Traditional Function
	return `Year released: ${year}`;
}

let releaseFunction: (someYear: number) => string; // Function Type

releaseFunction = ReleaseMessage; // Works because they have the same parameter and return types. The function has the same signature as the variable type.

let message: string = releaseFunction(2024);
```

### [Pure Functions](https://www.freecodecamp.org/news/pure-function-vs-impure-function/)

A *pure* function is a function without *side effects*, meaning it isn't dependent on code from outside the function. If, for example, a function uses a variable from outside its function scope it can fail if that variable state is not what you expect, like being undefined.
Same goes for objects like `console.log`. If that object gets modified, your function might stop functioning. So to make it pure, you have to work with parameters that make copies of the variables you need, and return values of the result is needed somewhere else, like to print to the console.

Impure example:
```js
const myNames = ["Oluwatobi", "Sofela"];

function updateMyName(newName) {
  myNames.push(newName);
  return myNames;
}
```

Same functionality, but pure:
```js
const compBio = ["code", "sweetly"];

function updateCompBio(newBio, array) {
  return [...array, newBio];
}

console.log(updateCompBio(".com", compBio));
```

---

## Interfaces

Contracts that define types, for the compiler to enforce through type checking.
Implementations of the interface are only allowed to have what is defined in the interface. Nothing more, and nothing less. Unless it is optional.

Syntax:
```ts
interface Name {
	requiredProperty: type;
	optionalProperty?: type;
	functionSignature: (parameter: type) => returnType;
}
```

Usages:
```ts
interface Movie {
	title: string;
	yearReleased: number; 
	streaming?: boolean;
}

let myMovie: Movie = {
	title: "Rogue One",
	yearReleased: 2016
	// streaming is optional
}
```

### Duck Typing

Because interfaces are enforced by type checking, if an object has the correct properties and types, it is allowed. Even if the object is not declared with the interface.
The object that only looks like the interface can also have extra properties that an object implementing the interface is not allowed to have.

*Example:*
```
interface Duck {
	walk: () => void;
	swim: () => void;
	quack: () => void;
}

let probablyADuck { // Not declared as a Duck
	walk: () => console.log("Walking like a duck.");
	swim: () => console.log("Swimming like a duck.");
	quack: () => console.log("Quacking like a duck.");
	extra: () => consle.log("Is extra like a duck can never be.")
}

function FlyOverWater(bird: Duck) { }

FlyOverWater(probablyADuck); // Works! Because the properties and types are equal.
```

### Interfaces for Function Types

Instead of:
```ts
let IdGenerator: (chars: string, nums: number) => string;
```

Same functionality with interface, way better readable:
```ts
interface StringGenerator {
	(chars: string, nums: number): string;
}

let IdGenerator: StringGenerator;
```

### Extending Interfaces

With keyword `extends`.

Syntax:
```ts
interface Interface1 {
	property1: type;
}
interface Interface2 {
	property2: type;
}

interface Interface3 extends Interface1, Interface2 {
	property3: type;
}

let example: Interface3 = {
	property1: type,
	property2: type,
	property3: type
}
```

---

## Classes

Syntax:
```ts
class ClassName {
	requiredPropertyName: type;
	optionalPropertyName?: type;
	static staticPropertyName: type = initializationValue; // Only available on
	// the class itself, not on instances of the class.

	get accessorPropertyName(): returnType { } // Getter and Setter Accessors.
	set accessorPropertyName(newValue: string) { } // Must have the same name.

	methodName(requiredParameter: type, optionalParameter?: type): returnType { }

	constructor(requiredParameter: type, optionalParameter?: type) {
		// Initialization, called with new keyword and class type.
	}
}
```

### Parameter Properties

Tells the compiler to make a property of the same name as a parameter and assign the value, with keyword `public`.
No explicit property declaration and assignment in the constructor needed.

```ts
class ClassName {
	constructor(public parameterPropertyName: type) { }
}
```

### Access Modifiers

- `public`– the default.
- `private`– only accessible within the class, not in subclasses.
	- `#` – private fields, keeps private after compiling to JS (only after ES2021)
- `protected` –  only accessible within the class AND subclasses. Not public on instances.

### Class Types from Interface

With keyword `implements`.

*Example:*
```c#
interface ITeacher {
	name: string;
	doWork: () => void; // name: () => returnType
}

class HighSchoolTeacher implements Teacher {
	name: string; // Property
	doWork () { // Method
		// Code
	}
}

let class1Teacher: Teacher = new HighSchoolTeacher();

class1Teacher.doWork();
class1Teacher.name = "Jos";
```

### Inheritance

Make subclass with `extends` keyword.

If the subclass has a constructor, it needs to call the constructor of the superclass as well with `super();`. Even if that superclass only has a hidden constructor. This basically adds the properties and methods of the superclass.

*Example:*
```ts
class Teacher {
	name: string = "";
	doWork(): void { } // name (): returnType
}

class HighSchoolTeacher extends Teacher {
	subjects: string[];
	constructor(...subjects: string[]) { // If implementing its own constructor,
		super(); // needs to call the constructor of the superclass.
		this.subjects = subjects;
	}
	doWork(): void { // Method overriding
		super.doWork(); // Still do what the superclass version does.
		// Add new functionalities here.
	}
}
```

### Abstract Classes

Can not be directly instantiated.
Abstract methods are not implemented, and need to be implemented in derived subclasses.

*Example:*
```ts
abstract class Teacher {
	name: string = "";
	doWork(): void { } // name (): returnType
	abstract printInfo(): void; // No implementation
}

class HighSchoolTeacher extends Teacher {
	subjects: string[];
	constructor(...subjects: string[]) { // If implementing its own constructor,
		super(); // needs to call the constructor of the superclass.
		this.subjects = subjects;
	}
	printInfo(): void { // Abstract method from superclass needs implementation.
		console.log(`name: ${name}`);
		console.log(`subjects: ${subjects}`); // Prints all items in array.
	}
}
```

### Class Expressions

Can be used like traditional class:
```ts
abstract class Teacher {
	name: string = "";
	doWork(): void { } // name (): returnType
	abstract printInfo(): void; // No implementation
}

let HighSchoolTeacher = class extends Teacher { // Class expression
	subjects: string[];
	constructor(...subjects: string[]) {
		super(); // needs to call the constructor of the superclass.
		this.subjects = subjects;
	}
	printInfo(): void { // Abstract method from superclass needs implementation.
		console.log(`name: ${name}`);
		console.log(`subjects: ${subjects}`); // Prints all items in array.
	}
}
```

But could also be used wherever a class definition is expected:
```ts
class HighSchoolTeacher extends class {
	name: string = "";
	doWork(): void { }
} {
	subjects: string[];
	constructor(...subjects: string[]) { // If implementing its own constructor,
		super(); // needs to call the constructor of the superclass.
		this.subjects = subjects;
	}
	printInfo(): void { // Abstract method from superclass needs implementation.
		console.log(`name: ${name}`);
		console.log(`subjects: ${subjects}`); // Prints all items in array.
	}
}
```

---

## Modules

### Why Use Modules

- Encapsulation
- Reusability
- Create high-level abstractions

(Basically like SOLID in C#.)

### Exporting and Importing

#### Standard Export

Exporting is comparable to public items in C#, making them accessible to others outside the module. Indicated with the `export` keywords before an item, like interfaces, functions, or classes. Making it `export default` doesn't require imports to specify what they want to import from a module.

#### Export Statement

Multiple items as one, and adds the option to specify a name for outside modules with `as`.
Makes it clear in one place what is being exported.

At the bottom of the file.

```ts
export { InterfaceName, ClassName, FunctionName as Alias}
```

#### Importing

At the top of the file.

```ts
import { ItemName, Alias } from "./moduleFileName"; // Specify items to import.

import Alias from "./moduleFileName"; // Imports the default item of a module and specifies an Alias to use in this module.

import { ItemName as Alias } from "./moduleFileName"; // Import specific item(s) and assign an Alias to use in this module.

import * as Alias from "./moduleFileName"; // Import all exported items.
```


### Module Resolution

Compiler option: ``tsc --moduleResolution Classic | Node`.

Use relative references for your own modules:
```ts
import { ItemName, Alias } from "/moduleFileName"; // looks in root
import { ItemName, Alias } from "./moduleFileName"; // looks in current directory
import { ItemName, Alias } from "../FolderName/moduleFileName"; // goes one up, and looks in other directory with FolderName
```

Use non-relative references for external modules:
In `Node` mode the compiler looks in the `node_modules` directory for non-relative references.
```ts
import * as $ from "jquery";
import * as _ from "lodash";
```

---

## Asynchronous Code

### Promises

The Promise object represents the eventual completion/failure of an async operation and its resulting value.

- Cleaner and easier to read compared to callback functions.
- Added in ES2015.
- Small API: `then` and `catch`
- Similar to Tasks in C#.
- Can be chained together.

#### Creation

Creation takes an async function:
```ts
function asyncFunction(resolve, reject) {
	if (succes) resolve(data);
	else reject(reason);
}
let promiseName: Promise<GenericType> = new Promise(asyncFunction);
```

Same with arrow function:
```ts
let promiseName: Promise<GenericType> = new Promise((resolve, reject) => {
	if (succes) resolve(data);
	else reject(reason);
});
```

*Example:*
```ts
function GetMovieByDirector(director: string): Promise<string[]> {
	let p: Promise<string[]> = new Promise((resolve, reject) => {
		setTimeout(() => {
			let foundMovies: string[] = Utility.GetTitles(director);

			if  (foundMovies.length > 0) {
				resolve(foundMovies);
			}
			else {
				reject(`No movies found for director ${director}.`)
			}
		}, 2000); // Wait for 2 seconds / 2000ms, to simulate slow task.
	});
}
```

#### Handling Results

If the Promise gets resolved successfully, get data with `then`.
If it fails, or throws an exception, catch it with `catch`.

```ts
let promise: Promise<GenericType> = MethodThatReturnsPromise();
promise.then(dataOfSpecifiedGenericType => /* do something */ )
	   .catch(reason => /* do something */ ));
```

*Example:*
```ts
GetMovieByDirector("George Lucas")
	.then(titles => console.log(`Found titles ${titles}.`))
	.catch(reason => console.log(`Error: ${reason}`));
```

### Chaining Promises

*Example:*
```ts
GetMovieByDirector("George Lucas")
	.then(titles => {
		console.log(`Found titles ${titles}.`)
		return titles.length; // return resolve value
	}, reason => { return 0; }) // return reject value
	.then(numberOfMovies => console.log(`Number found: ${numberOfMovies}.`))
	.catch(reason => console.log(`Error: ${reason}`));
```


### `async` and `await`

Allows code to be written more linearly and indicates the compiler it should be executed asynchronous.
Async functions always return a Promise.

```ts
async function DoAsyncWork() {
	let result = await GetDataFromServer();
	console.log(result);
}
DoAsyncWork();
```

*Example:*
```ts
async function LogSearchResult(director: string) {
	let foundMovies = await GetMovieByDirector(director);
	// await returns the resolve value that you would get with .then
	console.log(result);
}
LogSearchResult("George Lucas") // Returns a Promise,
	.catch(reason => console.log(reason)); // so reject value can be caught.
```

---

## Generics

Code that works with multiple types by accepting *type parameters*.
Can be applied to functions, interfaces, and classes.

### Type Parameters

- Specify the type a generic will operate over.
- Represented by *T*.
- Actual type is provided at instance creation or function invocation.

### Array\<T\>

The following lines do the same thing, declare an array of type Book.
```ts
let books: Book[];
let books: Array<Book>; // The type Book here is a Type Parameter.
```

### Generic Function

```ts
function LogAndReturn<T>(thing: T): T {
	return thing;
}
let someString: string = LogAndReturn<string>("A string"); // Here T is replaced with the sepcified type: string.
```

### Generic Interfaces and Classes

Everywhere a Type Parameter *T* is used gets the type specified when created.

```ts
interface Inventory<T> {
	getNewestItem: () => T;
	addItem: (newItem: T) => void;
	getAllItems: () => Array<T>;
}
let bookInventory: Inventory<Book>;
```

```ts
class Catalog<T> implements Inventory<T> {
	private catalogItems = new Array<T>();
	addItem(newItem: T) {
		this.catalogItems.push(newItem);
	}
	// and the other interface methods
}
let bookCatalog = new Catalog<Book>();
```

### Generic Constraints

Describes types that may be passed as a generic parameter, applied with `extends` keyword.
This way, you can use properties and/or methods of that type.

```ts
interface CatalogItem {
	catalogNumber: number;
}
class Catalog<T extends CatalogItem> implements Inventory<T> { // Now only types that have a "catalogNumber: number" property are allowed (Duck Typing).
	// Implementations of interface methods.
}
```

---

## Type Declaration Files

TypeScript wrapper for existing JavaScript libraries, to make sure you are using the libraries correctly. It is a development-time tool.
If you start using a JavaScript library, check if there is a Declaration File available for it.

File extension: `.d.ts`

![[Pasted image 20231011122100.png]]

### DefinitelyTyped

GitHub repository containing thousands of type declaration files.
May be out of date.

Install with [npm](https://www.npmjs.com/) using `npm install @types/libraryName`

*Example after installation of lodash:*
```json
// package.json
{
	"dependencies": {
		"@types/lodash": "^4.14.199", // versions slightly out of sync, but ok
		"lodash": "^4.17.21"
	}
}
```

---

## Decorators

- Function that is applied to other code.
- Form of meta-programming.
- Similar to attributes in C#.
- May be applied to:
	- Classes
	- Methods
	- Properties
	- Fields
	- Getters/Setters

### TypeScript 5 Decorators

- Support to upcoming JavaScript decorator proposal.
- Not compatible with earlier TypeScript decorators.
- Do not use `--experimentalDecorators` or `--emitDecoratorMetadata` compiler flags.

### Applying Decorators

The following example is a decorator that replaces the method it is applied to with another function specified in the decorator function:

```ts
// declarations.ts
export function logMethodInfo(
	orignialMethod: any, _context: ClassMethodDecoratorContext) {
	
	function replacementMethod(this: any, ...args: any[]) {
		// replacement functionality
	}
	return replacementMethod;
}
```

```ts
// classes.ts
import { logMethodInfo } from "./decorators";

class ClassName ... {
	...
	@logMethodInfo
	methodName(): void {
		...
	}
}
```

---

## Debugging

Debugging with Source Maps lets you execute the JavaScript code for debugging, but with setting breakpoints and watches in the source TypeScript.
Enabled with `--sourceMap` compiler option, creates a `.js.map` file for each JavaScript file.

### NodeJS Debugger in VS Code

Steps:
1. Enable the `--sourceMap` compiler option in `tsconfig.json`.

2. Compile code with `tsc`and open a JavaScript Debug Terminal: ![[Pasted image 20231011125542.png]]

3. Attach the debugger: ![[Pasted image 20231011125836.png]]

4. Find the variables you are looking for in the Variables window on the top left: ![[Pasted image 20231011130015.png]]
   
   You can also add a Watcher to keep track of certain variables: ![[Pasted image 20231011130129.png]]
   ![[Pasted image 20231011130200.png]]

#### Configure launch.json

![[Pasted image 20231011130440.png]]

### Chrome DevTools

Steps:
1. Enable the `--sourceMap` compiler option in `tsconfig.json`.
2. Compile code with `tsc` in a terminal.
3. Create HTML file to view the compiled JS code.
4. Open the HTML file in Chrome.
5. Press F12 to open DevTools.
6. Through Source Maps the `.ts` files are available in the Sources tab.
7. Use the DevTools Debugger: [Debugging Sites with Chrome DevTools by Brice Wilson](https://app.pluralsight.com/library/courses/chrome-developer-tools-debugging-sites/table-of-contents)

![[Pasted image 20231011131121.png]]

---

## Filtering

Use `map` when performing `push` in a `foreach` loop.


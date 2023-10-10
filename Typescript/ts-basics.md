# TypeScript Basics

## Courses and References

- [TypeScript documentation](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes-oop.html)
- [Pluralsight: TypeScript 5 Fundamentals by Brice Wilson](https://app.pluralsight.com/library/courses/typescript-5-fundamentals/table-of-contents)

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

if (typeof(someValue) == string){
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
let strArray1: string[] = ["here", "are", "string"];
let strArray2: Array<string> = ["more", "strings"]; // With Generic
let anyArray: any[] = [42, true, "banana"]; // Mix of types, avoid!
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

switch (fruit){
	case "orange":
		console.log("Orange")
		break;
	default:
		console.log("Don't know.")
}
```

---

## Functions

```ts
function GetReview(title: string): string | number { // return type after
	return "Something";
}
```
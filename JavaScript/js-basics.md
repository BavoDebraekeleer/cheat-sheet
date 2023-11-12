# JavaScript Basics

## Courses and Reference

- [FreeCodeCamp: Pure functions](https://www.freecodecamp.org/news/pure-function-vs-impure-function/)
- [Mozilla Developer: JS Array methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array#iterative_methods)
- [Mozilla Developer: Spread syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax)

---

## Introduction

TO-DO

---

## Arrays

### Duplicating

To return a duplicate array in JS: `[...originalArray]`.

### [Array Methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array#iterative_methods)

| Mutating method (modifying the original)                                                                                                     | Non-mutating alternative                                                                                                      |
| ------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| [`copyWithin()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin) | No one-method alternative                                                                                                     |
| [`fill()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/fill)             | No one-method alternative                                                                                                     |
| [`pop()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop)               | [`slice(0, -1)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)                |
| [`push(v1, v2)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push)       | [`concat([v1, v2])`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat)           |
| [`reverse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reverse)       | [`toReversed()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toReversed)           |
| [`shift()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift)           | [`slice(1)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)                    |
| [`sort()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort)             | [`toSorted()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toSorted)               |
| [`splice()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice)         | [`toSpliced()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toSpliced)             |
| [`unshift(v1, v2)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift) | [`toSpliced(0, 0, v1, v2)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/toSpliced) |

### [Spread Syntax (...)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax)

The **spread (`...`)** syntax allows an iterable, such as an array or string, to be expanded in places where zero or more arguments (for function calls) or elements (for array literals) are expected. In an object literal, the spread syntax enumerates the properties of an object and adds the key-value pairs to the object being created.

---

## Date

Localisation:
- [HTML Language Codes](https://www.w3schools.com/tags/ref_language_codes.asp)
- [HTML Country Codes](https://www.w3schools.com/tags/ref_country_codes.asp)


[Date](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date) objects store an unambiguous representation of a specific moment in time:

> Note: It's important to keep in mind that while the time value at the heart of a Date object is UTC, the basic methods to fetch the date and time or its components all work in the local (i.e. host system) time zone and offset.

This should fully answer your question. Your date object is a pure, absolute date object even if the console prints it using your environment's timezone. You have plenty of date methods to handle your date as needed. Read the above linked documentation.

This is simply how JavaScript dates work. So there is nothing you can do to change this behavior.

Additionally:

> A JavaScript date is fundamentally specified as the number of milliseconds that have elapsed since midnight on January 1, 1970, UTC.

So, a date can be stored losslessly by storing the number of milliseconds since midnight on January 1, 1970, UTC (Use [Date.prototype.getTime()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime)). Consequently, our code can be rewritten as:

```javascript
const temp_deadline = new Date("2022-12-24T23:40:01Z");
const new_deadline = new Date(temp_deadline.getTime());

console.log(new_deadline);
```

`temp_deadline` and `new_deadline` above represent both the same exact date/instant in the same way.

Just remember:

- A date can be absolutely and completely represented by the number of milliseconds since midnight on January 1, 1970, UTC.
- A date object can be instantiated by using that number of milliseconds and will represent the exact date/instant all around the world, even if it is displayed in the local timezone.
- There are date methods that will automatically convert the core UTC representation into a local timezone representation (the majority of date methods).
- There are other special methods (UTC, ISO, GMT methods) that allow you to work with a "normalized" representation.
- **Date.prototype.getTime() is the absolutest and purest representation of a date in JavaScript.**




# React

## Courses and Documentation

- [Pluralsight: What is React? by Peter Kellner](https://app.pluralsight.com/library/courses/react-what-is/table-of-contents)
- [Pluralsight: React 18 Fundamentals by Roland Guijt](https://app.pluralsight.com/library/courses/react-18-fundamentals/table-of-contents)
- [Pluralsight: Testing in React 18 by Liam McLennan](https://app.pluralsight.com/library/courses/react-18-testing/table-of-contents)
- [React Docs: Reusing Logic with Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

- [Blog Post: Data Fetching in React Using SWR and TypeScript by Alejo Boga](https://betterprogramming.pub/mastering-data-fetching-in-react-using-swr-and-typescript-648df3b15efa)

---

## Introduction

Front-end library (not a framework) developed by Facebook to render complex UI in a Single Page App (SPA). — `react` and `reactDOM`.

![[Pasted image 20231024173136.png]]

Next.js, for example, is a framework that uses the React Library.

A React App is a tree of components that are represented in JavaScript code.
It is 100% component based.
All React apps start by rendering a single component.

Uses React JSX Syntax among normal JS code.

![[Pasted image 20231024152310.png]]
![[Pasted image 20231024152009.png]]
![[Pasted image 20231024152055.png]]

Why React exists:
![[Pasted image 20231024154005.png]]
![[Pasted image 20231024154037.png]]

### Functioning of React

- At app start the component in `/pages/index.js` is launched.
- That `index.js` contains the root element of the React app.

![[Pasted image 20231024170121.png]]

React maintains state for every component.
State changes cause apps to re-render with an updated UI.

Can not use JavaScript `let` to update data.

### Three Main Benefits

1. Structure with components - reusability and have state.
2. UIs declared in JavaScript - rendered ouput changes when state is updated.
3. Reconciliation - only updates the parts of the UI that changed.

### Toolchains for React

- Next.js
- Create React App (CRA)
- [Vite](https://vitejs.dev/guide/)

---
## Components

A component in React is a (arrow) function that return JSX code.

JSX code looks like HTML, but isn't. It is an alternative way of writing JavaScript
JSX = JavaScript eXtension.
Translated to JavaScipt by a tool, e.g., Babel.

### Component Function

![[Pasted image 20231024152342.png]]

![[Pasted image 20231024153638.png]]

### Component Arrow Function

```tsx
const App = () => {
	return (
		<div>
			<b>Hello World!</b>
		</div>
	)
}
```

### Component Class

Not recommended! Future additions will likeley only be supported with functions.

Another way of writing a component is with a class that inherits from `React.Component`:
```tsx
class App extends React.Component {
	render() {
		return (
			<div>
				<b>Hello World!</b>
			</div>
		)
	}
}
```

### Data between Parent and Child

- Passing data from parent to child, is through React element attributes.
- Passing data from child to parent, is by passing functions to child that get executed by that child component.

![[Pasted image 20231024170818.png]]

### React Server Components

React Server Components (RCS) are components that run inside a Node Server.

Components running on a server have (direct) access to different things:
![[Pasted image 20231024173623.png]]

---

## Styling

There are 4 ways to style a component:
- A CSS file for the whole application.
- Loading a CSS file into the HTML root document `index.html` - not always accassible.
- Applying a CSS file to a specific component.
- Using the *style* attribute on a component.

---

## React Hook

A way to track data changes over the lifetime of a component.

![[Pasted image 20231024153519.png]]

### Hook Form

```bash
npm install -D @hookform/devtools
```

---

## React UI Library (Styling Library)

Building UI components from scratch can be tedious and sometimes futile. This is why component libraries exist; they provide ready-to-use design elements, thereby allowing developers to focus on building the UI without building everything from scratch.

Options:
- [React Bootstrap](https://react-bootstrap.github.io/)
- [Material UI](https://mui.com/)

### Material UI

[Installation](https://mui.com/material-ui/getting-started/installation/):
```bash
npm install @mui/material @emotion/react @emotion/styled
npm install @fontsource/roboto
npm install @mui/icons-material
```

[Available Components](https://mui.com/material-ui/react-button/)

---

## Data Fetching (from API)

### SWR

[Data Fetching in React Using SWR and TypeScript by Alejo Boga](https://betterprogramming.pub/mastering-data-fetching-in-react-using-swr-and-typescript-648df3b15efa)

SWR, or Stale While Revalidate, is a data fetching library that handles data fetching, caching, and error handling in a performant manner.

Uses TypeScript, providing an extra layer of type safety.

#### Install alongside Axios

```batch
npm install swr axios
```
#### Usage

To use SWR with React, we need to use a hook called `useSWR` which returns some variables depending on the state of the `fetcher` function.

```ts
const fetcher = (...args) => fetch(...args).then(res => res.json())  
  
const {data, error, isLoading, isValidating} = useSWR(key, fetcher);
```

We can define these variables as follows:
- `data` –  This variable represents the book itself.
- `error`– If for some reason you can not find the book, this variable will contain the reasons why.
- `isLoading` – Thisvariable will have a boolean value of `true` when you are on your way to grab a book.
- `isValidating` – Thisvariable will be similar to `isLoading` but it will have the value of `true` when you are checking your records if you already have the book next to you. From now on, the place next to you will be called `cache`.
- `key` – Representsthe book the customer wants. It could be for example the title.

We can see this clearly in the next diagram:
![](https://miro.medium.com/v2/resize:fit:700/1*Asc71ccRQvHYYg6hL-zjTA.png)
*How SWR Works Under the Hood.*

Under the hood, SWR uses a cache to store data that has been previously fetched. In our example, this would be the closest bookshelf.

When a user requests data, SWR first checks the cache to see if it already has the data. If it does, it returns the cached data immediately. If not, it sends a request to the server to fetch the data, and once the data is returned, it stores it in the cache for future use.

---

### JSX

### [Conditional Rendering](https://legacy.reactjs.org/docs/conditional-rendering.html)

#### Inline If-Else with Conditional Operator

```jsx
<Component>
	{condition ?
		When true : When false
	}
</Component>
```


---
## Testing in React

![[Pasted image 20231025205731.png]]




---
## [Vite](https://vitejs.dev/guide/)



### [Vitest Testing Framework for Vite](https://vitest.dev/guide/)

Adding to a project:
```bash
npm install -D vitest
```

Adding npm script:
```json
{
  "scripts": {
    "test": "vitest",
    "test ui": "vitest --ui",
    "coverage": "vitest run --coverage"
  }
}
```

[Vitest VS Code extension](https://marketplace.visualstudio.com/items?itemName=ZixuanChen.vitest-explorer)
[How to make Vitest work in Visual Studio Code by Niclas Hummel](https://blog.stackademic.com/how-to-make-vitest-work-in-visual-studio-code-2e9e7fff274e)

--- 

## Debugging

With VS Code, go to Debug tab en press *Debug and Run* to go into debug mode to be able to use breakpoints. Going through the code can be done both in VS Code and the Chrome browser.

Additionally, in Chrome there is a *React Developer Tools* extensions that adds extra tabs, Performance and Components.

![[Pasted image 20231030073611.png]]


---
## VS Code Extensions

- [Simple React Snippets](https://github.com/burkeholland/simple-react-snippets)
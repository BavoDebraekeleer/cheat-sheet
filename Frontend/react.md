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

![[Pasted image 20231103151744.png]]

![[Pasted image 20231104113925.png]]

![[Pasted image 20231104114053.png]]

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

## React Hooks

A way to track data changes over the lifetime of a component.

![[Pasted image 20231024153519.png]]

### Hook Form

```bash
npm install -D @hookform/devtools
```

### [Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

When you extract logic into custom Hooks, you can hide the gnarly details of how you deal with some external system or a browser API. The code of your components expresses your intent, not the implementation.

*Example:*
```tsx
function useOnlineStatus() {  
	const [isOnline, setIsOnline] = useState(true);  
	
	useEffect(() => {  
		function handleOnline() {  
			setIsOnline(true);  
		}  
		function handleOffline() {  
			setIsOnline(false);  
		}  
		
		window.addEventListener('online', handleOnline);  
		window.addEventListener('offline', handleOffline);  
		
		return () => {  
			window.removeEventListener('online', handleOnline);  
			window.removeEventListener('offline', handleOffline);  
		};  
	}, []);  
	
	return isOnline;  
}
```

#### Extraction Example

Original code:
```js
// App.js

import { useState, useEffect } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  useEffect(() => {
    const id = setInterval(() => {
      setCount(c => c + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return <h1>Seconds passed: {count}</h1>;
}
```

Solution:
```js
// App.js
import { useCounter } from './useCounter.js';

export default function Counter() {
  const count = useCounter();
  return <h1>Seconds passed: {count}</h1>;
}
```

```js
// useCounter.js extracted Custom Hook
import { useState, useEffect } from 'react';

export function useCounter() {
  const [count, setCount] = useState(0);
  useEffect(() => {
    const id = setInterval(() => {
      setCount(c => c + 1);
    }, 1000);
    return () => clearInterval(id);
  }, []);
  return count;
}
```

When adding a state parameter, it needs to be added to the Effect’s dependencies, by adding it between the `[]` at the end of `useEffect`, like `delay` in the following example:
```js
// App.js
import { useState } from 'react';
import { useCounter } from './useCounter.js';

export default function Counter() {
  const [delay, setDelay] = useState(1000);
  const count = useCounter();
  return (
    <>
      <label>
        Tick duration: {delay} ms
        <br />
        <input
          type="range"
          value={delay}
          min="10"
          max="2000"
          onChange={e => setDelay(Number(e.target.value))}
        />
      </label>
      <hr />
      <h1>Ticks: {count}</h1>
    </>
  );
}

```

```js
// // useCounter.js Custom Hook
import { useState, useEffect } from 'react';

export function useCounter(delay) {
  const [count, setCount] = useState(0);
  useEffect(() => {
    const id = setInterval(() => {
      setCount(c => c + 1);
    }, delay);
    return () => clearInterval(id);
  }, [delay]);
  return count;
}
```

#### Naming Conventions

1. **React component names must start with a capital letter,** like `StatusBar` and `SaveButton`. React components also need to return something that React knows how to display, like a piece of JSX.
2. **Hook names must start with `use` followed by a capital letter,** like [`useState`](https://react.dev/reference/react/useState) (built-in) or `useOnlineStatus` (custom). Hooks may return arbitrary values.

#### Key Takeaways

- Custom Hooks let you share logic between components.
- Custom Hooks must be named starting with `use` followed by a capital letter.
- Custom Hooks only share stateful logic, not state itself.
- You can pass reactive values from one Hook to another, and they stay up-to-date.
- All Hooks re-run every time your component re-renders.
- The code of your custom Hooks should be pure, like your component’s code.
- Wrap event handlers received by custom Hooks into Effect Events.
- Don’t create custom Hooks like `useMount`. Keep their purpose specific.
- It’s up to you how and where to choose the boundaries of your code.

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

## [Lazy Loading](https://www.loginradius.com/blog/engineering/lazy-loading-in-react/)

Lazy loading is not a new concept. It has been available for quite some time. In essence, lazy loading means that a component or a part of code must get loaded when it is required. It is also referred to as `code splitting` and `data fetching`.

Talking about `React` specifically, it bundles the complete code and deploys all of it at the same time. Now, usually, that's not a bad idea, since React SPAs (Single page application) are quite small and do not affect the performance. But what if we have a gigantic application, like a content management system with a customer portal, admin portal etc. In such a case, it does not seem like a smart idea to load the complete application.


---
## Testing in React

![[Pasted image 20231025205731.png]]

See `General/testing-tdd


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
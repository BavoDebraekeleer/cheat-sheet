# React

## Courses and Documentation

- [Pluralsight: What is React? by Peter Kellner](https://app.pluralsight.com/library/courses/react-what-is/table-of-contents)
- [Pluralsight: React 18 Fundamentals by Roland Guijt](https://app.pluralsight.com/library/courses/react-18-fundamentals/table-of-contents)
- [Pluralsight: Testing in React 18 by Liam McLennan](https://app.pluralsight.com/library/courses/react-18-testing/table-of-contents)
- [React Docs: Reusing Logic with Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

- [Blog Post: Data Fetching in React Using SWR and TypeScript by Alejo Boga](https://betterprogramming.pub/mastering-data-fetching-in-react-using-swr-and-typescript-648df3b15efa)

- [5 Different Techniques for Cross Micro Frontend Communication - by Vishal Sharma](https://sharvishi9118.medium.com/cross-micro-frontend-communication-techniques-a10fedc11c59)
- [Event Bus for React - by Daw-Chih Liou](https://dawchihliou.github.io/articles/event-bus-for-react)
- [Decoupling React Components with an Event Bus - by Radovan Stevanovic](https://javascript.plainenglish.io/decoupling-react-components-with-an-event-bus-9d86170e09d7)


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
// package.json
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

[The 2023 guide to React debugging - by Anna Monus](https://raygun.com/blog/react-debugging-guide/#:~:text=For%20React%20debugging%2C%20the%20most,one%20by%20one%2C%20and%20more.)

With VS Code, go to Debug tab en press *Debug and Run* to go into debug mode to be able to use breakpoints. Going through the code can be done both in VS Code and the Chrome browser.

Additionally, in Chrome there is a *React Developer Tools* extensions that adds extra tabs, Performance and Components.

![[Pasted image 20231030073611.png]]

### Levels

1. `console.log()` statements
2. Debugger statement for debugging in the browser
3. Breakpoints in the IDE (VS Code)
	- Conditional Breakpoints
	- Pause on exception breakpoint

#### 1. Console Log

##### Object parameters

In code:
![[Pasted image 20231106152409.png]]
In browser Dev Tools:
![[Pasted image 20231106152457.png]]

##### Table for arrays

In code:
![[Pasted image 20231106152546.png]]
In browser Dev Tool:
![[Pasted image 20231106152715.png]]

##### Time

To measure how long it takes to trvale from one point in your code to another, with `console.time(label: labelName)` and `console.endTime(label: labelName)`.

![[Pasted image 20231106201708.png]]

![[Pasted image 20231106201605.png]]


#### 2. Debugger Statement

To debug in the browser, add the `debugger;` statement to add a code breakpoint.
ESLint will by default disable the debugger, so add `/* eslint-disable no-debugger */` to the top of the file to use debugging in that file, or `// eslint-disable-next-line no-debugger` before the debugger statement to allow just this one.

![[Pasted image 20231106152802.png]]


#### 3. With IDE

Go to the Debug tab and press play at the top:
![[Pasted image 20231106153847.png]]

Make sure the URL in `launch.json` matches the URL that is used withe the `dev` script.

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "type": "chrome",
            "request": "launch",
            "name": "Launch Chrome against localhost",
            "url": "http://localhost:5173/",
            "webRoot": "${workspaceFolder}"
        }
    ]
}
```

##### Conditional Breakpoints

Right click on breakpoint to add expression/condition:
![[Pasted image 20231106154410.png]]

![[Pasted image 20231106154435.png]]

##### Pause on exception breakpoint

Press the Pause on exceptions button in the Chrome Dev Tools - takes you to where an exception is thrown:
![[Pasted image 20231106154727.png]]

#### Network Tab

##### Replay, and Edit and Resend API Calls

Replay:
![[Pasted image 20231106200810.png]]

Edit and Resend:
![[Pasted image 20231106200923.png]]

Brings you to a Postman-esque interface:
![[Pasted image 20231106200935.png]]

---

## [Cross Microservices Communication](https://sharvishi9118.medium.com/cross-micro-frontend-communication-techniques-a10fedc11c59)

### Component Props

Pros:
- One of the very well-known techniques of data passing in component-based architecture.
- Most of the frameworks support this way.
- One can always use framework structs to avoid prop drilling issues e.g. React Context etc.

Cons:
- Adds a lot of coupling between the micro frontends and the container app.
- Hard to achieve if two micro frontends are not using the same framework
- It can impact the overall performance of the application as multiple unwanted layers will be re-rendered with every state change.

### Platform Storage APIs

Pros:
- Available for browsers as well as mobile devices. Local storage for browsers and Async storage for mobile apps.
- Less coupling compares to passing props between the App and micro frontend but hard to debug which micro frontend is setting the data.

Cons:
- Not a scalable solution for bigger applications. But can be used for a small set of data. It is always good to namespace the data set into platform storage according to the app name to avoid ambiguity.
- Not a secure technique for saving protected data.

### Custom Events

Pros:
- The inbuilt solution in-browser platform.
- Very much close to asynchronous event-based architecture in the microservices world. Easy for the backend developers to understand as well.
- High setup cost but easy to scale.
- Build a generic mechanism that all the micro frontend teams can follow.

Cons:
- Not achievable in the case of mobile micro frontends

### Event Bus Messaging

The message bus library can expose methods to publish, subscribe and unsubscribe the events. The publish event needs to make sure that all the subscribed handlers are invoked once the event is published.

> It is very important to make sure that all the micro frontends are using the same instance of the message bus, as an application should have only one registry for all the events published.

Pros:
- A custom-made solution equivalent to message bus in microservices implementation.
- High setup cost but easy to scale.
- Libraries like [Postal.js](https://github.com/postaljs/postal.js) are available in the market.

Cons:
- Similar to the custom events' technique, it can be hard to make all the micro frontends teams follow the same pattern.

#### Event Bus Pattern

An Event Bus is a design pattern that allows PubSub-style communication between components while the components remain loosely coupled.

A component can send a message to an Event Bus without knowing where the message is sent to. On the other hand, a component can listen to a message on an Event Bus and decide what to do with the message without knowing where the message comes from. With this design, independent components can communicate without knowing each other.

![[Pasted image 20231106210526.png]]

Parts:
- Event: The message being sent and received on an Event Bus.
- Publisher: The sender that ***emits*** an event.
- Subscriber: The receiver that ***listens*** to an event.

### Libraries

- `EventEmitter`
- `rxjs` — with Typescript support.

##### `rxjs`

###### Setup

```tsx
import { Subject } from 'rxjs';  
  
const eventBus = new Subject();
```
That's it!

###### Emitting Events

Example, using an enum for Event types:
```tsx
enum EventTypes {  
LOGIN = 'LOGIN',  
LOGOUT = 'LOGOUT',  
//... more events  
}  
  
eventBus.next({ type: EventTypes.LOGIN, payload: { username: 'johndoe' } });
```

###### Subscribing to events

```tsx
eventBus.subscribe((event) => {  
	switch (event.type) {  
		case EventTypes.LOGIN:  
			console.log(`User ${event.payload.username} has logged in`);  
			break;  
		case EventTypes.LOGOUT:  
			console.log(`User ${event.payload.username} has logged out`);  
			break;  
		default:  
			break;  
	}  
});
```

It’s recommended to handle the events in a separate service or store to avoid polluting the component with business logic and make it more testable.

![[Pasted image 20231106212753.png]]

###### Benefits of using an Event Bus in a React Application

1. Decoupling: An event bus allows different parts of an application to communicate with each other without being tightly coupled. This can make it easier to manage shared states and make the application more testable.
2. Centralized Event Handling: Having a central event bus makes it easier to manage and track the events happening in the application. This can be helpful for debugging and monitoring.
3. Asynchronous Actions: An event bus can consistently handle asynchronous actions across different application parts, such as API calls.
4. Improved Performance: By decoupling the components, they can be rendered independently. This can improve the overall performance of the application.
5. Better Code organization: By separating the event handling logic from the components and putting it in a separate service or store and making abstraction using custom hooks like `useEvents` with a predicate function to filter the events of interest, the code becomes more organized and easier to maintain.

###### Filter Events

How to make abstractions using custom hooks to filter the events of interest:
```tsx
import { useState, useEffect } from 'react';  
import { Subject } from 'rxjs';  
  
const eventBus = new Subject();  
  
const useEvents = (predicateFn) => {  
	const [events, setEvents] = useState([]);  
  
	useEffect(() => {  
		const subscription = eventBus
			.pipe(filter(predicateFn))
			.subscribe(setEvents);  
		
		return () => subscription.unsubscribe();  
	}, [predicateFn]);  
	  
	const publish = (event) => eventBus.next(event);  
	  
	return { events, publish };  
};
```


---

## [Context](https://react.dev/learn/passing-data-deeply-with-context)

TODO
### Prop Drilling

---
## VS Code Extensions

- [Simple React Snippets](https://github.com/burkeholland/simple-react-snippets)
# Authentication

## Auth0

[Auth0 Developer: Hello World Full-Stack Security:React/JavaScript + ASP.NET Core/C#](https://developer.auth0.com/resources/code-samples/full-stack/hello-world/basic-access-control/spa/react-javascript/aspnet-core-csharp)

Steps:
1. Get Auth0 account and create new Application.
2. Set URIs in Application settings.
3. Install in React:
```cli
npm install @auth0/auth0-react
```
4. Configure `Auth0Provider` component:
```tsx
...

var auth0Domain = import.meta.env.AUTH0_DOMAIN;
var auth0ClientId = import.meta.env.AUTH0_CLIENT_ID;

...
return (
	<Auth0Provider
        domain={auth0Domain}
        clientId={auth0ClientId}
        authorizationParams={{
          redirect_uri: window.location.origin
        }}
      >
		<App />
      </Auth0Provider>
);
```

### User Profile

Login with Microsoft Account:
```json
{ 
	"sub": "windowslive|dbce538656255249", 
	"given_name": "Bavo", 
	"family_name": "Debraekeleer", 
	"nickname": "Bavo Debraekeleer", 
	"name": "Bavo Debraekeleer", 
	"picture": "https://apis.live.net/v5.0/dbce538656255249/picture", 
	"locale": "nl-NL", 
	"updated_at": "2023-11-16T10:30:14.316Z" 
}
```
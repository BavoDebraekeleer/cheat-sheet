# Authentication

## Auth0

- [Auth0 Developer: Hello World Full-Stack Security:React/JavaScript + ASP.NET Core/C#](https://developer.auth0.com/resources/code-samples/full-stack/hello-world/basic-access-control/spa/react-javascript/aspnet-core-csharp)
- [Auth0: ASP.NET Core Web API: Authorization](https://auth0.com/docs/quickstart/backend/aspnet-core-webapi/01-authorization)
- [Auth0 (short version of the above): Add Authorization to an ASP.NET Core Web API Application](https://auth0.com/docs/quickstart/backend/aspnet-core-webapi/interactive)

### React Frontend

Steps:
1. Get Auth0 account and create new Application.
2. Set URIs in Application settings.
3. Install in React:
```cli
npm install @auth0/auth0-react
```
4. Configure `Auth0Provider` component:
```tsx
return (
	<Auth0Provider
        domain={import.meta.env.VITE_AUTH0_DOMAIN}
        clientId={import.meta.env.VITE_AUTH0_CLIENT_ID}
        authorizationParams={{
          //redirect_uri: window.location.origin
          redirect_uri: import.meta.env.VITE_AUTH0_REDIRECT_URI,
        }}
      >
		<App />
      </Auth0Provider>
);
```

#### User Profile

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

### ASP.NET Core Web API

- How to check for a JSON Web Token (JWT) in the `Authorization` header of an incoming HTTP request.
- How to check if the token is valid, using the [JSON Web Key Set (JWKS)](https://auth0.com/docs/tokens/concepts/jwks) for your Auth0 account. To learn more about validating Access Tokens, see [Validate Access Tokens](https://auth0.com/docs/tokens/guides/validate-access-tokens).

Steps:
1. Go to Dashboard/Applications/APIs on the Auth0 website and press Create API![[Pasted image 20231117113236.png]]
   
2. Fill in a name for the Dashboard and the URL of the API app, e.g.: `https://localhost:7144`. RS256 is a good standard encryption. ![[Pasted image 20231117113539.png]]

> By default, your API uses RS256 as the algorithm for signing tokens. Since RS256 uses a private/public keypair, it verifies the tokens against the public key for your Auth0 account. The public key is in the [JSON Web Key Set (JWKS)](https://auth0.com/docs/tokens/concepts/jwks) format, and can be accessed via https://{yourdomain}/.well-known/jwks.json

3. Add permission to the API ![[Pasted image 20231117114247.png]]

4. In Visual Studio, open the ASP.NET app and install package dependency via NuGet:
```
Install-Package Microsoft.AspNetCore.Authentication.JwtBearer
```

5. Configure the middleware:
```c#
// Program.cs
var domain = $"https://{builder.Configuration["Auth0:Domain"]}/";
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
.AddJwtBearer(options =>
{
    options.Authority = domain;
    options.Audience = builder.Configuration["Auth0:Audience"];
    options.TokenValidationParameters = new TokenValidationParameters
    {
        NameClaimType = ClaimTypes.NameIdentifier
    };
});
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("read:messages", policy => policy.Requirements.Add(new
    HasScopeRequirement("read:messages", domain)));
});
builder.Services.AddSingleton<IAuthorizationHandler, HasScopeHandler>();

...

app.UseAuthentication();
app.UseAuthorization();
```

```json
{
  "Auth0": {
    "Domain": "{yourDomain}", // tenant domain, dev-...
    "Audience": "{yourApiIdentifier}" // Dasboard/Applications/APIs, is URL
  }
}
```

6. Validate Scopes with an Authorization Requirement and an Authorization Handler:
```csharp
// HasScopeRequirement.cs

public class HasScopeRequirement : IAuthorizationRequirement
{
    public string Issuer { get; }
    public string Scope { get; }

    public HasScopeRequirement(string scope, string issuer)
    {
        Scope = scope ?? throw new ArgumentNullException(nameof(scope));
        Issuer = issuer ?? throw new ArgumentNullException(nameof(issuer));
    }
}
```

```csharp
// HasScopeHandler.cs

public class HasScopeHandler : AuthorizationHandler<HasScopeRequirement>
{
    protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, HasScopeRequirement requirement)
    {
        // If user does not have the scope claim, get out of here
        if (!context.User.HasClaim(c => c.Type == "scope" && c.Issuer == requirement.Issuer))
            return Task.CompletedTask;

        // Split the scopes string into an array
        var scopes = context.User.FindFirst(c => c.Type == "scope" && c.Issuer == requirement.Issuer).Value.Split(' ');

        // Succeed if the scope array contains the required scope
        if (scopes.Any(s => s == requirement.Scope))
            context.Succeed(requirement);

        return Task.CompletedTask;
    }
}
```

7. Add `[Authorize]` attribute to controller actions, for example:
```csharp
// Controllers/ApiController.cs

[Route("api")]
[ApiController]
public class ApiController : ControllerBase
{
    [HttpGet("private")]
    [Authorize]
    public IActionResult Private()
    {
        return Ok(new
        {
            Message = "Hello from a private endpoint! You need to be authenticated to see this."
        });
    }
}
```

> To secure endpoints that require specific scopes, we need to make sure that the correct scope is present in the `access_token`. To do that, add the `Authorize` attribute to the `Scoped` action and pass `read:messages` as the `policy` parameter.

```csharp
// Controllers/ApiController.cs

[Route("api")]
public class ApiController : Controller
{
    [HttpGet("private-scoped")]
    [Authorize("read:messages")]
    public IActionResult Scoped()
    {
        return Ok(new
        {
            Message = "Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this."
        });
    }
}
```

For more info on the Authorize attribute: [Microsoft Learn: Simple authorization in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/security/authorization/simple?view=aspnetcore-8.0)


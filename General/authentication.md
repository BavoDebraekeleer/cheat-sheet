# Authentication

## JWT

- [Article: Using JWT for authentication in React](https://blog.openreplay.com/using-jwt-for-authentication-in-react/)

![[Pasted image 20231122211708.png]]

A JWT token consists of three parts:
1. Header — JSON object containing info on the token, like the used algorithm and token type, `Base64Url` encoded. For example:
```json
{ "alg": "HS256", "typ": "JWT" }
```

2. Payload / claims / body — JSON object containing the data, like user info, permissions, and expiration time, `Base64Url` encoded. For example:
```json
{ "sub": "1234567890", "name": "John Doe", "iat": 1516239022 }
```

3. Signature — used to verify the integrity of the token, calculated using a secret key known only by the server. For example:
```json
HMAC256(base64UrlEncode(header) + "." + base64UrlEncode(payload), secret_key);
```

You can decode a JWT token in [this online debugger](https://jwt.io/) to read the token and see the different parts.

## Auth0

Authorization server solution that works with JWT.

- [Auth0 Developer: Hello World Full-Stack Security:React/JavaScript + ASP.NET Core/C#](https://developer.auth0.com/resources/code-samples/full-stack/hello-world/basic-access-control/spa/react-javascript/aspnet-core-csharp)
- [Auth0: ASP.NET Core Web API: Authorization](https://auth0.com/docs/quickstart/backend/aspnet-core-webapi/01-authorization)
- [Auth0 (short version of the above): Add Authorization to an ASP.NET Core Web API Application](https://auth0.com/docs/quickstart/backend/aspnet-core-webapi/interactive)

### Auth0 Dashboard

Steps:
1. Go to Dashboard/Applications/APIs on the Auth0 website and press Create API![[Pasted image 20231117113236.png]]
   
2. Fill in a name for the Dashboard and the URL of the API app, e.g.: `https://localhost:7144`. RS256 is a good standard encryption. ![[Pasted image 20231117113539.png]]

> By default, your API uses RS256 as the algorithm for signing tokens. Since RS256 uses a private/public keypair, it verifies the tokens against the public key for your Auth0 account. The public key is in the [JSON Web Key Set (JWKS)](https://auth0.com/docs/tokens/concepts/jwks) format, and can be accessed via https://{yourdomain}/.well-known/jwks.json

3. Add permission to the API ![[Pasted image 20231117114247.png]]

### React Frontend

#### Basic Setup

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

#### Adding Access Token to Headers

[LogRocket Article: Using Axios to set request headers — Nelosn Michael](https://blog.logrocket.com/using-axios-set-request-headers/)

Globally:
```tsx
axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.getItem('access_token')}`;
```

Or:
```cs
const accessToken = "...";

export const api = axios.create({
    baseURL: 'https://localhost:1000/api/',
    headers: {
        'Authorization': `Bearer ${accessToken}`
    }
});
```

### ASP.NET Core Web API

- How to check for a JSON Web Token (JWT) in the `Authorization` header of an incoming HTTP request.
- How to check if the token is valid, using the [JSON Web Key Set (JWKS)](https://auth0.com/docs/tokens/concepts/jwks) for your Auth0 account. To learn more about validating Access Tokens, see [Validate Access Tokens](https://auth0.com/docs/tokens/guides/validate-access-tokens).


1. In Visual Studio, open the ASP.NET app and install package dependency via NuGet:
```
Install-Package Microsoft.AspNetCore.Authentication.JwtBearer
```

2. Configure the middleware:
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
    // !! without https:// at the start, and / at the end !!
    "Audience": "{yourApiIdentifier}" // Dasboard/Applications/APIs, is URL
  }
}
```
Example:
```json
"Auth0": {
  "Domain": "dev-aaaaaaaaaaaaaa.eu.auth0.com",
  "Audience": "https://localhost:5000"
},
"Authentication": {
  "Schemes": {
    "Bearer": {
      "Authority": "https://dev-aaaaaaaaaaaaaa.eu.auth0.com/",
      "ValidAudiences": [ "https://localhost:5000" ],
      "ValidIssuer": "https://dev-aaaaaaaaaaaaaa.eu.auth0.com/"
    }
  }
}
```

3. Validate Scopes with an Authorization Requirement and an Authorization Handler:
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

4. Add `[Authorize]` attribute to controller actions, for example:
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

### Skip User Consent

When user consent is needed the user will be prompted for it.
To skip this, an application needs to be marked as first party and the Skip User Consent options needs to be turned on for the API being called.

Steps:

#### 1. localhost

Modify the hosts file.
1. Open Notepad as Administrator.
2. Open the hosts file: `C:\Windows\System32\drivers\etc\hosts`
3. Add to the bottom:
```txt
	127.0.0.1		local.auth
	::1             local.auth
	localhost		local.auth
```

#### 2. Auth0 Dashboard

##### Application

Make sure the Allowed Callback URLs in the Application's Settings don't include `localhost`, but instead the host that was set up for it, `local.auth` If one localhost is still present, it won't be viewed as first party and will require user consent no matter the settings.

##### API

In the Auth0 Dashboard set the API to allow skipping user consent y going to the API's Settings:
![[Pasted image 20231120111341.png]]


#### 3. Mark Application as First Party

By making a PATCH request to the Auth0 Managamenet API:
```
url: https://dev-....eu.auth0.com/api/v2/clients/{applications client ID}
body raw: { "is_first_party": true }
```

First get an access token:
![[Pasted image 20231120110407.png]]

With Postman:
![[Pasted image 20231120105903.png]]
![[Pasted image 20231120105759.png]]

With cURL:
```curl
curl --request PATCH \
  --url 'https://dev-r5hvdjgh0rkep2qc.eu.auth0.com/api/v2/clients/{App Client ID}' \
  --header 'authorization: Bearer {access token}' \
  --header 'cache-control: no-cache' \
  --header 'content-type: application/json' \
  --data '{ "is_first_party": "true" }'
```

Response:
```json
{
    "tenant": "dev-r5hvdjgh0rkep2qc",
    "global": false,
    "is_token_endpoint_ip_header_trusted": false,
    "name": "TimesheetApp",
    "is_first_party": true,
    "oidc_conformant": true,
    "sso_disabled": false,
    "cross_origin_auth": false,
    "refresh_token": {
        "expiration_type": "expiring",
        "leeway": 0,
        "token_lifetime": 2592000,
        "idle_token_lifetime": 1296000,
        "infinite_token_lifetime": false,
        "infinite_idle_token_lifetime": false,
        "rotation_type": "rotating"
    },
    "allowed_clients": [],
    "callbacks": [
        "https://local.auth:5173"
    ],
    "native_social_login": {
        "apple": {
            "enabled": false
        },
        "facebook": {
            "enabled": false
        }
    },
    "allowed_logout_urls": [
        "https://local.auth:5173"
    ],
    "organization_require_behavior": "no_prompt",
    "organization_usage": "deny",
    "signing_keys": [
        {
            "cert": "-----BEGIN CERTIFICATE-----...-----END CERTIFICATE-----\r\n",
            "pkcs7": "-----BEGIN PKCS7-----...-----END PKCS7-----\r\n",
            "subject": "/CN=dev-r5hvdjgh0rkep2qc.eu.auth0.com"
        }
    ],
    "allowed_origins": [
        "https://local.auth:5173",
        "https://local.auth:7144"
    ],
    "client_id": "jxttC9PA2NiZZyMhA1k8NWMBgYeDxCja",
    "callback_url_template": false,
    "client_secret": "970BzDSdU_H9OU8kbcrLDDq-dWiBkAZZQe8IJVLmOALPPAPHcocj3suCgcguNvRp",
    "jwt_configuration": {
        "alg": "RS256",
        "lifetime_in_seconds": 36000,
        "secret_encoded": false
    },
    "client_aliases": [],
    "token_endpoint_auth_method": "none",
    "app_type": "spa",
    "grant_types": [
        "authorization_code",
        "implicit",
        "refresh_token"
    ],
    "web_origins": [
        "https://local.auth:5173"
    ],
    "custom_login_page_on": true
}
```

To check the status:
![[Pasted image 20231120112528.png]]


### Troubleshooting

![[Pasted image 20231120163224.png]]
# ASP .NET Core API

## Courses

- [Pluralsight Path: ASP.NET Core 6 Web API](https://app.pluralsight.com/paths/skills/aspnet-core-6-web-api)


---
## ASP .NET Core

ASP .NET Core is a Web Application Framework, combining frontend and backend.

![[Pasted image 20231016213353.png]]
![[Pasted image 20231016213421.png]]
![[Pasted image 20231016213444.png]]
![[Pasted image 20231016213749.png]]

![[Pasted image 20231016213859.png]]
![[Pasted image 20231016213937.png]]

---

## API Standards

![[Pasted image 20231016220945.png]]
![[Pasted image 20231016221027.png]]
![[Pasted image 20231016221054.png]]


### RESTfull Web API with Controller Pattern

Standard from outside .NET.

![[Pasted image 20231016214314.png]]
![[Pasted image 20231016214349.png]]


### Minimal API

Specify endpoints directly in the pipeline.
Without the build-in functionalities of a controller, e.g. validation.

![[Pasted image 20231016215535.png]]
![[Pasted image 20231016215555.png]]

### gRPC

Standard from outside .NET.
Tighter coupling.

![[Pasted image 20231016215909.png]]

#### Contract

Focus on performance, gives numbers to the properties in the models for seriealization.
For example, the Product in the following code:

![[Pasted image 20231016220040.png]]
![[Pasted image 20231016220151.png]]

![[Pasted image 20231016220424.png]]

### SignalR

Has the ability to call Client side methods from the backend server, e.g. to update products on a page.

1. Client calls the HUB on the backend server:![[Pasted image 20231016221825.png]]
2. Hub calls the method on all Clients:![[Pasted image 20231016221841.png]]

![[Pasted image 20231016221344.png]]

---


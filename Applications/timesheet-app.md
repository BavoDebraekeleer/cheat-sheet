# Timesheet

## .NET API

### Anatomy of a .NET API
    
- De API volgt de clean architecture, denk hierbij aan het volgende:
    - Inversion of control
    - Service lifetimes
        - Zoek op wat de verschillende lifetimes zijn en wanneer je de welke moet gebruiken
    - Ports and Adapters
        - 3 layers (Infrastructure, Domain, Presentation)
        - Mapping tussen de layers
    - Database
        - Entity Framework (Write)
        - Dapper (Read)
            - Wat is het verschil tussen Entity Framework en Dapper? Wat zijn de voordelen?
    - Maak gebruik van interfaces en generics waar nodig
    - Outside in testing


Feedback:
DateTime in controllers
DTO voor controllers
Timesheet validatie refactoren, eventueel met extensions
DeleteRegistrationHandler -> is await _employeeRepository.Update(employee); nodig?handleClickOnAddRegistration
# General Coding Guide

## KISS
Keep in simple and stupid!

## CQRS at small scale
Try to separate commands from queries on function or method basis:

* If a function returns a value do not change state inside the function.
* If a method / function mutates state, then it should not return a value.

## Parse don't validate
Leverage the type system to ensure state of validated objects.
Once validated return a safe, encapsulated object.

### Example
```csharp
public class Dto 
{
    // Name might be null from input. Check is required before access.
    [Required]
    public string? Name { get; set; }
}

public class Model 
{
    // Type ensures `Name` is not null here. Safe to use without checks 
    public required string Name { get; set; }
}
```

## Avoid overabstraction
Make sure that abstractins like base classes and interfaces are really abstractions.

* DO use interfaces and abstract classes to enforce separation of concerns.
  For example to keep Domain Model clean from infrastructure.
* DO NOT add base classes or interfaces if you do not expect multiple implementatios.


## DRY (Don't repeat yourself)
While code duplication is bad on the small scales, code duplication must not be evil.
See https://overreacted.io/the-wet-codebase/

### Make sure the code has the same reason to change
Example: GraphQL Queries should not be shared, as every query should fullfil a different use case.
* DO NOT centralize code when the duplication is a coincidence

### Libraries: Always provide building blocks
Do not move entire business logic to shared libraries. 
* DO provide low level building blocks
* CONSIDER to provide helpers to focus on the 90% use case, _additional_ to the building blocks.

## Avoid `InternalsVisibleToAttribute`
Internal code should be kept as an implementation detail of an assembly.
This is also true for tests.

* AVOID `InternalsVisibleTo` if possible.
* CONSIDER using and `Internal` namespace like ASP.NET Core or EF Core.

## Avoid generic repositories
Most implementations of generic repositories leak implementation details like `DbContext` objects or pass `IQueryable` directly to the OR mapper and hence inherit special rules for `IQueryable`.

Also in some cases generic repositories make it hard to build the most efficient code.

* AVOID generic repositories
* DO write repositories for your use case

### EF Core
If your application decided to rely on EF Core all the time, it is totally valid to avoid Repository and Unit of Work pattern alltogethere as these are already implemented in `DbSet` and `DbContext`.


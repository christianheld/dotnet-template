# C# Coding principals

## Records
Records are a great addition for value objects (in the sense of DDD).

* DO use records if you need value semantics
* DO NOT use records just to write less code

Samples:

```cs
// Good - Object has value semantics
public record Address(string Street, string PostalCode, string City);

// Bad - Object no value semantics
public record Person(int Id, string Name);

// Alternative: 
public class Person 
{
    public required int Id { get; init; }
    public required string Name { get; init; }
}
```

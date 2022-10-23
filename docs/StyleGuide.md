# Project Style Guide

## C#

### Code Analysis / Warnings
* Follow rules defined in `.globalconfig`
* Fix all compiler warnings of possible

#### Disable Warnings
If this is not possible suppress the
warning and make clear in the comment why the warning has been suppressed.

Prefer `SuppressMessageAttribute` over `#pragma warning disable`

### Avoid `public` or `protected` fields
Properties come almost for free, thanks to compiler optimization. Prefer using properties where
possible. This will allow you to change implementation in a non breaking way.

## Readability
Visual structure of the code should make it easy to understand the code.

### Wrapping
Always Wrap to the next line and indent by 4 to keep the visual strucure simple  
BAD: (Not refactoring safe / creates lots of different margins in code)
```csharp
var customers = dbContext.Customers.Where(customer => customer.Company == company)
                                   .Select(customer => customer.Name)
                                   .AsNoTracking()
                                   .SingleOrDefault(cancellationToken);
```
GOOD:
```csharp
var customers = dbContext.Customers
    .Where(customer => customer.Company == company)
    .Select(customer => customer.Name)
    .AsNoTracking()
    .SingleOrDefault(cancellationToken);
```

#### Parameters
Wrap all or no parameters:
GOOD:
```csharp
public static async ValueTask LongMethodNameAsync(
    string text,
    int count,
    CancellationToken cancellationToken = default);
```

BAD: No visual structure. Easy to overread parameters
```csharp
public static async ValueTask LongMethodNameAsync(string text, int count,
    CancellationToken cancellationToken = default);
```

#### LINQ
Put every LINQ Operator in a new line.

GOOD:
```csharp
var items = myList
    .Where(x => x.IsGood)
    .Select(x => x.Name)
    .FirstOrDefault();
```

BAD:
```csharp
var items = myList.Where(x => x.IsGood)
    .Select(x => x.Name).FirstOrDefault();
```

### Follow the 100 / 24 rule
* Do not exceed column 100.
* Write short methods. Try not to exceed 24 lines of code.

### Order
A consistent order helps to navigate through the code.

Use CodeMaid's default ordering:
* Fields
* Constructors
* Finalizers
* Delegates
* Events
* Properties
* Indexers
* Methods
* Inner Structs
* Inner Classes

Write `static` before non.static, then order by visibility from `public` to `private` 

### Regions
Do not use Regions! `#endregions`

### Comments
In general comments should add value. Do not describe *what`the code does, describe *why*.

#### Use methods to name code blocks
Section comments are a good indicator how to split code into smaller methods.

BAD
```csharp
// Read Data 
var data = await _dbContext
    .Where(x => x.Count > 42)
    .ToListAsync();

// Map to DTOs
var dtos = data.Select(x => new Dto(x.Name, x.Value));
```

GOOD
```csharp
var data = await ReadDataAsync();
var dtos = MapToDtos(data);
```

#### XML Comments
Avoid empty XML comment blocks. Do not leak implementation details.

BAD: Empty comment section
```csharp
/// <summary>
/// This method does something
/// </summary>
/// <param name="parameter"></param>
public void Method(string parameter);
```
GOOD: No unused XML
```csharp
/// <summary>
/// This method does something
/// </summary>
public void Method(string parameter);
```
BAD: Leaks implementation details and not refactoring safe.
```csharp
/// <summary>
/// The product id. Value: <c>MySuperProduct</c>
/// </summary>
public const string ProductId = "MySuperProduct"
```

### Expression Bodied Members
Expression Bodied Members are great for short single line methods. However, in some cases it makes
code harder to read. 

GOOD: Clean single line method
```csharp
public void Save() => Save(_defaultFileName);
```

BAD:
```csharp
public bool TooMuchCodeInExpression() => (DataSet
    .WithFluent()
    .AndEvenMoreFluent()
    .OrNull() ?? SomeOtherStuff()) + 27 == 12;
``` 

Acceptable - No Branching logic
```csharp
public int? GetOrderCount(string name) =>
    _dbContext.Customers
        .Where(x => x.Name == name)
        .Select(x => x.OrderCount)
        .SingleOrDefault().
```

BAD - No Visual distinction between parameters and method body
```csharp
public Task<int> MethodAsync(
    string veryLongString,
    CancellationToken cancellationToken = default) =>
    await DoSomethingAsync(veryLongString);
```
GOOD
```csharp
public Task<int> MethodAsync(
    string veryLongString,
    CancellationToken cancellationToken = default)
{
    return await DoSomethingAsync(veryLongString);
}
```

### Async / Await
* Prefer `await` over directly returning `Task`
* Add `CancellationToken` parameter when possible
* Use `CancellationToken` parameter when possible

#### Do not hide asynchronous code in paranthesis
BAD: Async call hidden in expression
```csharp
var count = 37 * (await GetDataAsync()).Count;
```

GOOD: 
```csharp
var list = await GetDataAsync();
var count = 37 * list.Count;
```

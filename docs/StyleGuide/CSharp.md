# C# Coding Rules

## Follow Analysis Rules
Follow rules provided in the `.editorconfig` file.

## Warnings
Always strive to compile with zero compiler warnings.

### How to suppress Warnings
If a warning cannot be fixed for some reasons, then add a comment _why_.

* PREFER using `SuppressMessageAttribute` over `#pragma warning disable`
* DO provide a comment why a warning has been suppressed.

## Avoid `public` and `protected` fields
C#'s properties come almost for free.
In contrast to fields, properties can be changed in a non-breaking way.
Also, most tooling expects properties.

* AVOID `public` or `protected` fields

## Readbility
Code is read way more often than written.
Focus on readabilty!

Both methods and local variables are a good, refactoring safe way to name things.
Try to structure the code, so that the visual structure makes it easy to understand the code.

### Genernal rules
Follow the [General Rules](./General.md).
* DO cleanup code you are working on
* DO NOT cleanup unrelated code
* AVOID to exceed column 100
* DO write small chunks of code

### Blank Lines
* DO NOT add multiple consecutive blank lines
* DO add a blank line after a wrapped / multiline statement
* DO add blank lines after code blocks, e.g. `for` or `if`
* DO NOT add black line before `else` or `if else` blocks

GOOD:
```csharp
public async Task<Item?> GetItemAsync(int id, CancellationToken cancellationToken)
{
    CheckId(id);
    var item = await _service.GetItemAsync(
        id,
        true,
        cancellationToken);
    
    if (item is null)
    {
        return null;
    }

    return MapToDto(item);
}
```

BAD:
```csharp
public async Task<Item?> GetItemAsync(int id, CancellationToken cancellationToken)
{
    CheckId(id);
    var item = await _service.GetItemAsync(
        id,
        true,
        cancellationToken);    
    if (item is null)
    {
        return null;
    }


    return MapToDto(item);
}
```

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
* Write static before non.static, then order by visibility from public to private

## Regions
* DO NOT use Regions! `#endregions`.

You may break this rule if you use libraries that rely on regions like [Try .NET](https://dotnet.microsoft.com/en-us/platform/try-dotnet) 

## Wrapping / Intendation
Indent and wrap code by 4 or multiples of four. Do not create many different margins.

This will ensure, the code is easy to read and refactoring safe as renaming identifiers will not screw up formatting.

### Parameters
Wrap and indent all or no parameters:

GOOD:
```csharp
public void MethodName(
    int number,
    string veryLongString,
    CancellationToken cancellationToken = default);
```

BAD:
```csharp
public void MethodName(int number, string veryLongString,
                       CancellationToken cancellationToken = default);
```

### Fluent APIs / LINQ
Alignment by 4 also applies for fluent APIs.

* DO align fluent APIs by 4s and multiples by 4
* DO provide visual structure (e.g. double indent `Include()`)
* AVOID multiple fluent calls / operators in one line

GOOD:
```csharp
var customers = dbContext.Customers
    .Where(customer => customer.Company == company)
        .Include(customer => customer.Address)
    .Select(customer => customer.Name)
    .AsNoTracking()
    .SingleOrDefault(cancellationToken);
```

BAD. Invalid Margins, no structure
```csharp
var customers = dbContext.Customers.Where(customer => customer.Company == company)
                                   .Include(customer => customer.Address)
                                   .Select(customer => customer.Name)
                                   .AsNoTracking()
                                   .SingleOrDefault(cancellationToken);
```
BAD. Multiple operators in one line

```csharp
var items = myList.Where(x => x.IsGood)
    .Select(x => x.Name).FirstOrDefault();
```

## Comments
* DO comment _why_ not _what_ code does

### XML Comments
* DO NOT write empty XML comment blocks. 
* DO NOT leak implementation details.

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

## Expression Bodied Members
Expression bodied members are great for simple single line code.
Do not try to put code into a single expression, just because you can.

GOOD: Clean single line method
```csharp
public void Save() => Save(_defaultFileName);
```

BAD: Too much logic for a single line
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

## Asynchronous Code
Read [Asynchronous Programming](https://github.com/davidfowl/AspNetCoreDiagnosticScenarios/blob/master/AsyncGuidance.md).

* Prefer `await` over directly returning `Task`.
* Add and use `CancellationToken` if possible.

### ConfigureAwait
Do use `ConfigureAwait()` on multi-purpose library code or if your application uses a synchronization context. (MAUI, Blazor, WinForms, WPF).

Do not pollute code with `ConfigureAwait` if it is not necessary (E.g. ASP.NET Core)

### Do not hide asynchronus calls
BAD: Async call hidden in expression
```csharp
var count = 37 * (await GetDataAsync()).Count;
```

GOOD: 
```csharp
var list = await GetDataAsync();
var count = 37 * list.Count;
```

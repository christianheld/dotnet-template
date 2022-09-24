# Project Style Guide

## C#

### Code quality / maintainability
Follow rules defined in `.globalconfig`

#### Warnings
In general code should compile without compiler warnings. If this is not possible suppress the
warning and make clear in the comment why the warning has been suppressed

BAD:
```csharp
#pragma warning disable xxx
    public void MethodWithWarnings()
    {
    }
#pragma warning restore xxx
```

GOOD:
```csharp
#pragma warning disable xxx // Description why the warning has been disabled
    public void MethodWithWarnings()
    {
    }
#pragma warning restore xxx
```

### Avoid `public` or `protected` fields
Properties come almost for free, thanks to compiler optimization. Prefer using properties where
possible. This will allow you to change implementation in a non breaking way.

## Code Style
Follow rules defined in `.editorconfig` and make sure you have seen Definitely watch
[ITT 2016 - Kevlin Henney - Secven Innefective Coding Habits of Many Programmers](https://youtu.be/ZsHMHukIlJY)

Additionally following rules apply
### Identation
Visual structure of the code should make it easy to understand the code.

Always Wrap to the next line and indent by 4 to keep the visual strucure simple
GOOD: 
```csharp
var customers = dbContext.Customers
    .Where(customer => customer.Company == company)
    .Select(customer => customer.Name)
    .AsNoTracking()
    .SingleOrDefault(cancellationToken);
```

BAD: (Not refactoring safe / creates lots of different margins in code)
```csharp
var customers = dbContext.Customers.Where(customer => customer.Company == company)
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

BAD:
```csharp
public static async ValueTask LongMethodNameAsync(string text, int count,
    CancellationToken cancellationToken = default);
```

#### LINQ
Put every LINQ Operator in a new line
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

### 120 / 24 Rule
Methods should not exceeed column 120 and in general should not consist of more than 20 lines. 

> Why 120
> 
> Allow side-by-side diffs. The actual number is defined by educated guess (screen size)

### Code Ordering
Try to keep consistent order in classes. (Stick with CodeMaid defaults).

In general follow this order:
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

Order by `static` before instances, then by scope `public` to `private`, then by name (optional)

### Regions
`#endregions`. Avoid Regions. Regions are usually an indicator for bad code, use code constructs to structure code.

### Comments
Do not write Ghost comments. Comments should provide value.

#### Inline Comments
Comment *why* the code does something, do not comment *what* the code does. Use variables and methods to name constructs in code!

Keep in mind that comments are not refactoring safe, while methods are

BAD
```csharp
// Get customer names at our city
var customers = customers
    .Where(c => c.Address.City == OurCity)
    .ToList();
```

GOOD
```csharp
var customers = GetCustomersAtCity(OurCity);
```

#### XML Comments
Write XML comments for public documentation. Omit comments if everything is clear! Do not write empty
comments:

BAD: Empty comment section
```csharp
/// <summary>
/// This method does something
/// </summary>
/// <param name="parameter"></param>
public void Method(string parameter);
```

BETTER: No unused stuff
```csharp
/// <summary>
/// This method does something
/// </summary>
public void Method(string parameter);
```

### Expression Bodied Members
Expression Bodied Members are great for short single line methods. Avoid writing expression bodied
members just becaus you can.

GOOD: Clean single line method
```csharp
public void Save() => Save(_defaultFileName);
```

BAD:
```csharp
public int TooMuchCodeInExpression() => (DataSet
    .WithFluent()
    .AndEvenMoreFluent()
    .OrNull() ?? SomeOtherStuff()) + 27 == 12;
``` 

#### Do not use Expression bodied methods with wrapped paramters
Method content should be easyily distinguishable from parameters

BAD
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
* Prefer using  `await` over directly returning `Task`, see
* Support cancellation and pass `CancellationToken` when possible.
* Read https://github.com/davidfowl/AspNetCoreDiagnosticScenarios/blob/master/AsyncGuidance.md

#### Do not hide asynchronous calls
If method is `await`ed it deserves to be easily recognizable. Prefer multiple lines over hiding
`await` in parenthesis.

BAD
```csharp
var count = (await GetDataAsync()).Count;
```

GOOD
```csharp
var list = await GetDataAsync();
var count = list.Count;
```

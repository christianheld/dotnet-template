var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello, World!");

app.Run();

#pragma warning disable CA1050 // false positive
public partial class Program
{
}
#pragma warning restore CA1050

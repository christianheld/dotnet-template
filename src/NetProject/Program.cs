#pragma warning disable CA1812 // Class is never instanciated - Will be fixed in .NET7

using NetProject;

var sample = new SampleClass("World");

Console.WriteLine(sample.Greeting);

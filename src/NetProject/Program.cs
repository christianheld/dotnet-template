#pragma warning disable CA1812 // False postive for top level programs
using NetProject;

var sample = new SampleClass("World");

Console.WriteLine(sample.Greeting);


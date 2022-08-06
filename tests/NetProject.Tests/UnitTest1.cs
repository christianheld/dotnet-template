namespace NetProject.Tests;

public class SampleClassTests
{
    [Fact]
    public void ItWorks()
    {
        // Arrange
        var sut = new SampleClass("World");

        Assert.Equal("Hello, World", sut.Greeting);
    }
}

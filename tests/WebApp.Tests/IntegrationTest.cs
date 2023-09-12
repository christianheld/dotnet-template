using Microsoft.AspNetCore.Mvc.Testing;

namespace WebApp.Tests;

public class IntegrationTest
{
    [Fact]
    public async Task ReturnsHelloWorld()
    {
        // Arrange
        using var webapp = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    // Override services here
                });
            });

        using var client = webapp.CreateClient();

        // Act
        var response = await client.GetAsync("");
        var stringContent = await response.Content.ReadAsStringAsync();

        // Assert
        Assert.Multiple(() =>
        {
            Assert.True(response.IsSuccessStatusCode);
            Assert.Contains("Hello, World!", stringContent, StringComparison.Ordinal);
        });
    }
}

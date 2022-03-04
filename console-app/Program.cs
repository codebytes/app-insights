IConfigurationRoot configuration = new ConfigurationBuilder()
.AddJsonFile("appsettings.json")
.AddEnvironmentVariables()
.AddUserSecrets<Program>()
.Build();

// you may use different options to create configuration as shown later in this article

Console.WriteLine("ApplicationInsights telemetry client created");

// Create a TelemetryConfiguration instance.
#region APPINSIGHTS_CONFIG
TelemetryConfiguration telemetryConfiguration = TelemetryConfiguration.CreateDefault();
telemetryConfiguration.ConnectionString = configuration["ApplicationInsights:ConnectionString"];
QuickPulseTelemetryProcessor quickPulseProcessor = null;
telemetryConfiguration.DefaultTelemetrySink.TelemetryProcessorChainBuilder
    .Use((next) =>
    {
        quickPulseProcessor = new QuickPulseTelemetryProcessor(next);
        return quickPulseProcessor;
    })
    .Build();

var quickPulseModule = new QuickPulseTelemetryModule();

// Secure the control channel.
// This is optional, but recommended.
quickPulseModule.AuthenticationApiKey = "yayolce6gkwcqynxb8u60dq11t7dkik41fiduf5y";
quickPulseModule.Initialize(telemetryConfiguration);
quickPulseModule.RegisterTelemetryProcessor(quickPulseProcessor);
#endregion

// Create a TelemetryClient instance. It is important
// to use the same TelemetryConfiguration here as the one
// used to setup Live Metrics.
TelemetryClient client = new TelemetryClient(telemetryConfiguration);

BackgroundTask(client);
int count = 0;
// This sample runs indefinitely. Replace with actual application logic.
while (count < 20)
{
    // Send dependency and request telemetry.
    // These will be shown in Live Metrics stream.
    // CPU/Memory Performance counter is also shown
    // automatically without any additional steps.
    Console.WriteLine("Foreground Task");

    client.TrackEvent("Foreground Task - test event");

    client.TrackDependency("My dependency", "target", "http://sample",
        DateTimeOffset.Now, TimeSpan.FromMilliseconds(300), true);

    client.TrackRequest("My Request", DateTimeOffset.Now,
        TimeSpan.FromMilliseconds(230), "200", true);

    Task.Delay(1000).Wait();
}


static async Task BackgroundTask(TelemetryClient telemetryClient)
{
    await Task.Run(() =>
    {
        var operation = telemetryClient.StartOperation<DependencyTelemetry>("background Task");
        operation.Telemetry.Type = "Background";
        try
        {
            telemetryClient.TrackEvent("background started");
            int progress = 0;
            while (progress < 100)
            {
                Console.WriteLine("Background Task");
                // Process the task.
                telemetryClient.TrackTrace($"Background Task - done: {progress++}%");
                Task.Delay(500).Wait();
            }
            // Update status code and success as appropriate.
        }
        catch (Exception e)
        {
            telemetryClient.TrackException(e);
            // Update status code and success as appropriate.
            throw;
        }
        finally
        {
            telemetryClient.TrackEvent("Background Task finished");
            telemetryClient.StopOperation(operation);
        }
    });
}

using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.DataContracts;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Extensions.Logging;

namespace aspAppInsights
{
    public class DemoTelemetryInitializer : ITelemetryInitializer
    {
        public void Initialize(ITelemetry telemetry)
        {
            // Get the request telemetry.
            var requestTelemetry = telemetry as RequestTelemetry;

            if (requestTelemetry == null)
            {
                // If the standard (or any custom) telemetry modules did not issue a 'TrackRequest', return.
                return;
            }

            // Example of setting a standard Context telemetry property.
            requestTelemetry.Context.User.AuthenticatedUserId = "Chris Ayers";

            requestTelemetry.Properties["IsDemo"] = "true";
        }
    }
}
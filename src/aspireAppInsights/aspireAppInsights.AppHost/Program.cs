var builder = DistributedApplication.CreateBuilder(args);

var insights = builder.AddAzureApplicationInsights("MyApplicationInsights");

var apiService = builder.AddProject<Projects.aspireAppInsights_ApiService>("apiservice")
    .WithReference(insights);


builder.AddProject<Projects.aspireAppInsights_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(insights)
    .WithReference(apiService);

builder.Build().Run();

var builder = DistributedApplication.CreateBuilder(args);

var apiService = builder.AddProject<Projects.aspireApp_ApiService>("apiservice");

builder.AddProject<Projects.aspireApp_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(apiService);

builder.Build().Run();

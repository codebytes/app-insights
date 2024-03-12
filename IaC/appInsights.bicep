param appInsightsName string
param location string = resourceGroup().location
param workspaceName string

resource workspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: workspaceName
}

resource appInsights 'microsoft.insights/components@2020-02-02-preview' = {
  name: appInsightsName
  location: location
  kind: 'string'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
}

output Name string = appInsightsName
output InstrumentationKey string = appInsights.properties.InstrumentationKey

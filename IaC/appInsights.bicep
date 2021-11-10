param appInsightsName string
param location string = resourceGroup().location

resource appInsights 'microsoft.insights/components@2020-02-02-preview' = {
  name: appInsightsName
  location: location
  kind: 'string'
  properties: {
      Application_Type: 'web'
  }
}

output Name string = appInsightsName
output InstrumentationKey string = appInsights.properties.InstrumentationKey

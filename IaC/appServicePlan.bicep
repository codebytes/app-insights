param appServicePlanName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2019-08-01' = {
    name: appServicePlanName
    location: location
    sku: {
        name: 'S1'
    }
}

output Id string = appServicePlan.id

param webAppName string
param location string = resourceGroup().location

param appInsightsInstrumentationKey string
param appServicePlanId string
param useAppInsights bool = true

resource app 'Microsoft.Web/sites@2018-11-01' = {
    name: webAppName
    location: location
    identity: {
        type: 'SystemAssigned'
    }
    properties: {
        siteConfig: {
            appSettings: (useAppInsights ? [
                {
                    name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                    value: appInsightsInstrumentationKey
                }
                {
                    name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
                    value: '~2'

                }
                {
                    name: 'XDT_MicrosoftApplicationInsights_Mode'
                    value: 'recommended'
                }
                {
                    name: 'InstrumentationEngine_EXTENSION_VERSION'
                    value: '~1'
                }

                {
                    name: 'XDT_MicrosoftApplicationInsights_BaseExtensions'
                    value: '~1'
                }
                {
                    name: 'XDT_MicrosoftApplicationInsights_PreemptSdk'
                    value: '1'
                }
                {
                    name: 'APPINSIGHTS_PROFILERFEATURE_VERSION'
                    value: '1.0.0'
                }
                {
                    name: 'APPINSIGHTS_SNAPSHOTFEATURE_VERSION'
                    value: '1.0.0'
                }
                {
                    name: 'DiagnosticServices_EXTENSION_VERSION'
                    value: '~3'
                }
            ] : [])
        }
        serverFarmId: appServicePlanId
    }
}

output webAppName string = webAppName

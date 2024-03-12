param webAppName string = uniqueString(resourceGroup().id) // Generate unique String for web app name
param useAppInsights bool = true
param location string = resourceGroup().location

var appServicePlanName = toLower('AppServicePlan-AppInsights')
var webSiteName = toLower('wapp-${webAppName}')
var appInsightsName = toLower('ai-${webAppName}')
var logAnalyticsName = toLower('la-appInsights')

module appServicePlan 'appServicePlan.bicep' = {
    name: appServicePlanName
    params: {
        appServicePlanName: appServicePlanName
        location: location
    }
}

module logAnalytics 'logAnalytics.bicep' = {
    name: logAnalyticsName
    params: {
        workspaceName: logAnalyticsName
        location: location
    }
}

module appInsights 'appInsights.bicep' = if (useAppInsights) {
    name: appInsightsName
    params: {
        appInsightsName: appInsightsName
        workspaceName: logAnalytics.name
        location: location
    }
}

module webApp 'webapp.bicep' = {
    name: webSiteName
    params: {
        webAppName: webSiteName
        useAppInsights: useAppInsights
        appServicePlanId: appServicePlan.outputs.Id
        appInsightsInstrumentationKey: useAppInsights ? appInsights.outputs.InstrumentationKey : ''
        location: location
    }
}

output webAppName string = webSiteName

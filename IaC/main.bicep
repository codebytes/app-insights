param webAppName string = uniqueString(resourceGroup().id) // Generate unique String for web app name
param useAppInsights bool = true

var appServicePlanName = toLower('AppServicePlan-AppInsights')
var webSiteName = toLower('wapp-${webAppName}')
var appInsightsName = toLower('ai-${webAppName}')


module appServicePlan 'appServicePlan.bicep' = {
    name: appServicePlanName
    params:{
        appServicePlanName: appServicePlanName
    }
}

module appInsights 'appInsights.bicep' = if (useAppInsights) {
    name: appInsightsName
    params: {
        appInsightsName: appInsightsName
    }
}

module webApp 'webapp.bicep' = {
  name: webSiteName
  params: {
    webAppName: webSiteName
    useAppInsights: useAppInsights
    appServicePlanId: appServicePlan.outputs.Id
    appInsightsInstrumentationKey: useAppInsights ? appInsights.outputs.InstrumentationKey : ''
  }
}

output webAppName string = webSiteName

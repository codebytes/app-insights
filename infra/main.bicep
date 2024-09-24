targetScope = 'subscription'

// The main bicep module to provision Azure resources.
// For a more complete walkthrough to understand how this file works with azd,
// see https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/make-azd-compatible?pivots=azd-create

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

// Optional parameters to override the default azd resource naming conventions.
// Add the following to main.parameters.json to provide values:
// "resourceGroupName": {
//      "value": "myGroupName"
// }
param resourceGroupName string = ''

var abbrs = loadJsonContent('./abbreviations.json')

// tags that should be applied to all resources.
var tags = {
  // Tag all resources with the environment name.
  'azd-env-name': environmentName
}

// Generate a unique token to be used in naming resources.
// Remove linter suppression after using.
#disable-next-line no-unused-vars
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

// Name of the service defined in azure.yaml
// A tag named azd-service-name with this value should be applied to the service host resource, such as:
//   Microsoft.Web/sites for appservice, function
// Example usage:
//   tags: union(tags, { 'azd-service-name': apiServiceName })
#disable-next-line no-unused-vars
// var apiServiceName = 'python-api'
param basicAspSiteServiceName string = ''
param blazorAppServiceName string = ''
param aspAppInsightsServiceName string = ''
param applicationInsightsDashboardName string = ''
param applicationInsightsName string = ''
param logAnalyticsName string = ''
param appServicePlanName string = ''

// Organize resources in a resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags
}

module appSvcPlan 'core/host/appserviceplan.bicep' = {
  name: 'appSvcPlan'
  scope: rg
  params: {
    name: !empty(appServicePlanName) ? appServicePlanName : '${abbrs.webServerFarms}${resourceToken}'
    location: location
    tags: tags
    kind: 'linux'
    sku: {
      name: 'B3'
    }
  }
}

module basicAspSite 'core/host/appservice.bicep' = {
  name: !empty(basicAspSiteServiceName) ? basicAspSiteServiceName : '${abbrs.webSitesAppService}basicAspSite-${resourceToken}'
  scope: rg
  params: {
    name: !empty(basicAspSiteServiceName) ? basicAspSiteServiceName : '${abbrs.webSitesAppService}basicAspSite-${resourceToken}'
    location: location
    tags: union(tags, { 'azd-service-name': !empty(basicAspSiteServiceName) ? basicAspSiteServiceName : 'basicAspSite' })
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    appServicePlanId: appSvcPlan.outputs.id
    runtimeName: 'dotnetcore'
    runtimeVersion: '8.0'
  }
}

module blazorApp 'core/host/appservice.bicep' = {
  name: !empty(blazorAppServiceName) ? blazorAppServiceName : '${abbrs.webSitesAppService}blazorApp-${resourceToken}'
  scope: rg
  params: {
    name: !empty(blazorAppServiceName) ? blazorAppServiceName : '${abbrs.webSitesAppService}blazorApp-${resourceToken}'
    location: location
    tags: union(tags, { 'azd-service-name': !empty(blazorAppServiceName) ? blazorAppServiceName : 'blazorApp' })
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    appServicePlanId: appSvcPlan.outputs.id
    runtimeName: 'dotnetcore'
    runtimeVersion: '8.0'
  }
}

module aspAppInsights 'core/host/appservice.bicep' = {
  name: !empty(aspAppInsightsServiceName) ? aspAppInsightsServiceName : '${abbrs.webSitesAppService}aspAppInsights-${resourceToken}'
  scope: rg
  params: {
    name: !empty(aspAppInsightsServiceName) ? aspAppInsightsServiceName : '${abbrs.webSitesAppService}aspAppInsights-${resourceToken}'
    location: location
    tags: union(tags, { 'azd-service-name': !empty(aspAppInsightsServiceName) ? aspAppInsightsServiceName : 'aspAppInsights' })
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    appServicePlanId: appSvcPlan.outputs.id
    runtimeName: 'dotnetcore'
    runtimeVersion: '8.0'
  }
}

// Monitor application with Azure Monitor
module monitoring './core/monitor/monitoring.bicep' = {
  name: 'monitoring'
  scope: rg
  params: {
    location: location
    tags: tags
    logAnalyticsName: !empty(logAnalyticsName) ? logAnalyticsName : '${abbrs.operationalInsightsWorkspaces}${resourceToken}'
    applicationInsightsName: !empty(applicationInsightsName) ? applicationInsightsName : '${abbrs.insightsComponents}${resourceToken}'
    applicationInsightsDashboardName: !empty(applicationInsightsDashboardName) ? applicationInsightsDashboardName : '${abbrs.portalDashboards}${resourceToken}'
  }
}

// Add outputs from the deployment here, if needed.
//
// This allows the outputs to be referenced by other bicep deployments in the deployment pipeline,
// or by the local machine as a way to reference created resources in Azure for local development.
// Secrets should not be added here.
//
// Outputs are automatically saved in the local azd environment .env file.
// To see these outputs, run `azd env get-values`,  or `azd env get-values --output json` for json output.
output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId

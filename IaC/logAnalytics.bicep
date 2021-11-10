param workspaceName string
param location string = resourceGroup().location
 
resource workspaceName_resource 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
    name: workspaceName
    location: location
}
 
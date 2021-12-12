@description('The location where to deploy the resource')
param location string

@description('The name of the app service plan')
param appServicePlanName string

@description('The name of the web app')
param webAppName string


module appService 'Modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    webName: webAppName
  }
}


output webPhpName string = appService.outputs.webAppName

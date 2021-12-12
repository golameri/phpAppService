param location string
param appServicePlanName string
param webName string


var privateDNSZoneName = 'privatelink.azurewebsites.net'

resource privateDnsZones 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDNSZoneName
  location: 'global'
}

// creates app service plan
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  kind: 'Linux'
  properties: {    
    reserved: true
  }
  sku: {
    name: 'P1v3'
  }
}

// creates app service app in the defined app service plan
resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    clientAffinityEnabled: false
    siteConfig: {      
      linuxFxVersion: 'PHP|7.3'
      alwaysOn: true
    }
  }
}

output webAppName string = appServiceApp.name



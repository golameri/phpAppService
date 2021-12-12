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

// resource webAppAppSettings 'Microsoft.Web/sites/config@2020-06-01' = {
//   name: '${appServiceApp.name}/appsettings'
//   properties: {
//     'WEBSITE_DNS_SERVER': '168.63.129.16'
//     'WEBSITE_VNET_ROUTE_ALL': '1'
//   }
// }

output webAppName string = appServiceApp.name



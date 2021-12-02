
param location string
param suffix string

// creates app service plan
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'serviceplan-php-${suffix}'
  location: location
  kind: 'Linux'
  properties: {    
    reserved: true
  }
  sku: {
    name: 'B2'
  }
}

// creates app service app in the defined app service plan
resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: 'app-php-${suffix}'
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

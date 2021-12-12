param location string
param suffix string
param webAppPrivateEndpointName string 
param webAppPrivateDnsName string 
param webAppPrivateLinkName string 
param webAppSubnetName string 
param webAppSubnetAddressPrefix string 

resource hubVnet 'Microsoft.Network/virtualNetworks@2020-06-01' existing  = {
  name: 'hubVnet'
}

resource webAppSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' = {
  name: '${hubVnet.name}/${webAppSubnetName}'
  properties: {
    addressPrefix: webAppSubnetAddressPrefix
    privateEndpointNetworkPolicies: 'Disabled'
  }
}


// creates app service plan
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'serviceplan-php-${suffix}'
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


resource webAppPrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: webAppPrivateEndpointName
  location: location
  properties: {
    subnet: {
      id: webAppSubnet.id
    }
    privateLinkServiceConnections: [
      {
        name: webAppPrivateLinkName
        properties: {
          privateLinkServiceId: appServiceApp.id
          groupIds: [
            'sites'
          ]
        }
      }
    ]
  }
}

resource appServicePrivateDNSZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: webAppPrivateDnsName
  location: 'global'
}

resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${appServicePrivateDNSZone.name}/${appServicePrivateDNSZone.name}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: hubVnet.id
    }
  }
}

resource webAppPrivateDNSZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  name: '${webAppPrivateEndpoint.name}/dnsgroupname'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: appServicePrivateDNSZone.id
        }
      }
    ]
  }
}

output webAppName string = appServiceApp.name



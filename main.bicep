param location string
param fileShareName string
param adminUsername string
@secure()
param adminPassword string

var suffix = uniqueString(resourceGroup().id)

// parameters for app service
param webAppSubnetAddressPrefix string
param webAppPrivateEndpointName string
param webAppPrivateDnsName string
param webAppPrivateLinkName string
param webAppSubnetName string

module storageAccount 'Modules/storage.bicep' = {
  name: 'storage'
  params: {
    fileShareName: fileShareName
    location: location
    suffix: suffix
  }
}

module appService 'Modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    suffix: suffix
    webAppSubnetAddressPrefix: webAppSubnetAddressPrefix
    webAppPrivateEndpointName: webAppPrivateEndpointName
    webAppPrivateDnsName: webAppPrivateDnsName
    webAppPrivateLinkName: webAppPrivateLinkName
    webAppSubnetName:webAppSubnetName
  }
}

module mySql 'Modules/mySql.bicep' = {
  name: 'mySql'
  params: {
    location: location
    suffix: suffix
    adminPassword: adminPassword
    adminUserName:adminUsername
  }
}


output webPhpName string = appService.outputs.webAppName
output storageName string = storageAccount.outputs.storageName
output storageKey string = storageAccount.outputs.accessKey
output mySqlName string = mySql.outputs.mySqlName

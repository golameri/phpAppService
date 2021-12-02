param location string
param fileShareName string

var suffix = uniqueString(resourceGroup().id)

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
  }
}


output webPhpName string = appService.outputs.webAppName
output storageName string = storageAccount.outputs.storageName
output storageKey string = storageAccount.outputs.accessKey

@description('The location where to deploy the resource')
param location string

@description('The name of the Azure storage')
param strName string

@description('The name of the fileshare')
param fileShareName string

module str 'Modules/storage.bicep' = {
  name: 'str'
  params: {
    fileShareName: fileShareName
    location: location
    strName: strName
  }
}

output storageName string = str.outputs.storageName
output storageKey string = str.outputs.accessKey

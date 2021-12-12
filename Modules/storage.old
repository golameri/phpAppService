param suffix string
param fileShareName string
param location string

// creates Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'storage${suffix}'
  location: location
  kind:'StorageV2'
  sku:{
    name:'Standard_LRS'
  }
  properties:{
    accessTier: 'Hot'
  }
}

// creates file share
resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: '${storageAccount.name}/default/${fileShareName}'
}

output storageName string = storageAccount.name
output accessKey string = storageAccount.listKeys().keys[0].value

param strName string
param fileShareName string
param location string

var privateDNSZoneName = 'privatelink.file.core.windows.net'

resource privateDnsZones 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDNSZoneName
  location: 'global'
}

// creates Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: strName
  location: location
  kind:'StorageV2'
  sku:{
    name:'Standard_LRS'
  }
  properties:{
    accessTier: 'Hot'
    networkAcls: {
      defaultAction: 'Deny'
    }
  }
}

// creates file share
resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: '${storageAccount.name}/default/${fileShareName}'
}

output storageName string = storageAccount.name
output accessKey string = storageAccount.listKeys().keys[0].value

param suffix string
param adminUserName string
param location string
@secure()
param adminPassword string

// creates MySQL--Flexible servers
resource mySql 'Microsoft.DBforMySQL/flexibleServers@2021-05-01' = {
  name: 'mysql-${suffix}'
  location: location
  sku: {
    name: 'Standard_B2s'
    tier: 'Burstable'
  }
  properties: {
    administratorLogin: adminUserName
    administratorLoginPassword: adminPassword
    createMode: 'Default'

    sourceServerResourceId: 'string'
    storage: {
      autoGrow: 'Disabled'
      iops: 492
      storageSizeGB: 64
    }
    version: '5.7'
  }
}

output mySqlName string = mySql.name

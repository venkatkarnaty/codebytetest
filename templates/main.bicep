param storageAccountName string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource cdnProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: '${storageAccountName}-cdnprofile'
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/endpoints@2021-06-01' = {
  name: '${storageAccountName}-cdnendpoint'
  location: location
  profileName: cdnProfile.name
  isHttpAllowed: false
  isHttpsAllowed: true
  origins: [
    {
      name: storageAccountName
      hostName: storageAccount.name
      httpPort: 80
      httpsPort: 443
      useHttps: true
    }
  ]
}

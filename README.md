# Introduction

This Github create an Linux App Service with File Share attached to it and a MySQL Database.

# Create Azure Resources

To create the Azure resources open a bash terminal, you can use the one in the Azure Portal.  Clone the git repository and run those command lines.

The **Azure CLI** will be used to deploy this Bicep template.

```bash
LOCATION='replace with the location where you want to deploy the resources'
RG_HUB='Replace with name of your hub resource group'
RG_SPOKE='The name of the spoke resource group'
APP_SERVICE_PLAN_NAME='The name of the app service plan'
WEB_APP_NAME='The name of the web app name'
STR_NAME='The name of the storage'
FILESHARENAME='the name of the fileshare'

# Create the resource group
az deployment group create --resource-group $RG_HUB --template-file hub.bicep --parameters location=$LOCATION \
appServicePlanName=$APP_SERVICE_PLAN_NAME webAppName=$WEB_APP_NAME


az deployment group create --resource-group $RG_SPOKE --template-file spoke.bicep --parameters location=$LOCATION \
strName=$STR_NAME fileShareName=$FILESHARENAME

```

Once the deployment is finished, you should see an ouput section like this.

![img](https://raw.githubusercontent.com/golameri/phpAppService/master/pictures/outputs.png)

Copy the value of the **storageKey**,**storageName**, you need it to mounth the file share to the Web App.

Now run the command below, be sure to put the mounth path to what it's used in your application.

```bash

az webapp config storage-account add --resource-group $RG_HUB --name $WEB_APP_NAME --custom-id myid --storage-type AzureFiles \
--share-name $FILESHARENAME --account-name $STR_NAME --access-key "<access-key>" --mount-path <mount-path-directory>

```

To verify that you storage is mounted correctly you can run the following command

```bash
az webapp config storage-account list --resource-group $RG_HUB --name $WEB_APP_NAME
```
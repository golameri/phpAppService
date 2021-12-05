# Introduction

This Github create an Linux App Service with File Share attached to it and a MySQL Database.

# Create Azure Resources

To create the Azure resources open a bash terminal, you can use the one in the Azure Portal.  Clone the git repository and run those command lines.

The **Azure CLI** will be used to deploy this Bicep template.

```bash
RG='replace with name of your resource group'
LOCATION='replace with the location where you want to deploy the resources'
MYSQL_ADMIN_NAME='replace with your admin username'
MYSQL_ADMIN_PASSWORD='replace with admin password'
FILESHARENAME='the name of the fileshare'

# Create the resource group
az group create -n $RG -l $LOCATION

az deployment group create --resource-group $RG --template-file main.bicep --parameters location=$LOCATION fileShareName=$FILESHARENAME \
adminUsername=$MYSQL_ADMIN_NAME adminPassword=$MYSQL_ADMIN_PASSWORD

```

Once the deployment is finished, you should see an ouput section like this.

![img](https://raw.githubusercontent.com/golameri/phpAppService/master/pictures/outputs.png)

Copy the value of the **storageKey**,**storageName** and **webPhpName**, you need it to mounth the file share to the Web App.

Now run the command below, be sure to put the mounth path to what it's used in your application.

```bash

az webapp config storage-account add --resource-group $RG --name <app-name> --custom-id myid --storage-type AzureFiles \
--share-name $FILESHARENAME --account-name <storage-account-name> --access-key "<access-key>" --mount-path <mount-path-directory>

```

To verify that you storage is mounted correctly you can run the following command

```bash
az webapp config storage-account list --resource-group $RG --name <app-name>
```
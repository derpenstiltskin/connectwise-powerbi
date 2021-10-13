# Connect Power BI to ConnectWise Manage

This function will query the specified ConnectWise Manage API based on the parameters you pass to the function.To be able to use the CWApiRequest function provided, you must replace the API placeholder values listed below.

## Features

- Handles authentication to the ConnectWise Manage REST API
- Automatically manages API request paging, no action needed to retrieve over 1000 records
- Option to automatically expand all return columns that contain records
- Specify conditions to the API to filter the data
- Specify fields (columns) you want the API to return
- Specify how you want to sort the returned 
- Able to be pushed to Power BI online and have the dataset automatically refresh

## ToDo

- Implement childConditions
- Implement customFieldConditions

## Parameters

- ApiEndpoint (text) - API endpoint you will be querying (ex: "service/tickets")
- Conditions (text) - Conditions to filter your request to the API (ex: "closedFlag=false")
- Fields (text) - Comma delimited, no space, list of fields to return with the response (ex: "id,summary,company")
- OrderBy (text) - The field you want to sort by and the direction (ex: "id desc")
- ExpandColumnRecord (logical) - Set to true if you want the function to automatically expand column records (ex: true)

## API Placeholders (Replace these with your values)

- AUTHORIZATION_VALUE - This value is a base64 encoding of YourCWCompany+YourApiPublicKey:YourApiPrivateKey
- CLIENTID_VALUE - This is a ClientID you register for at https://developer.connectwise.com
- CW_API_URL_VALUE - This is the URL to your ConnectWise instance, including the API (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")

## Power BI Online

This function can be used for datasets that are pushed to Power BI Online. The only option you will need to change once you have the dataset in Power BI online, is to modify the authentication settings for the dataset and have it to skip Authentication Checks. Once you have done that, the dataset can be scheduled to refresh automatically.

## Download

[CWApiRequest](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/src/CWApiRequest.pq)

## Samples

[Get Open Service Tickets](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/src/SAMPLE_GetOpenServiceTickets.pq)

## ConnectWise REST API Documentation

[ConnectWise Developer](https://developer.connectwise.com/Products/Manage/REST)

## Special Thanks

The basis of this function is based on the work that [Quinntin Comer](https://comertechnology.com/) did for this [article](https://comertechnology.com/cw-manage-getting-started-with-powerbi-the-update/).
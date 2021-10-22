# Connect Power BI to ConnectWise Manage and Automate

This function will query the specified ConnectWise Manage or Automate API based on the parameters you pass to the function. To be able to use the CWApiRequest function provided, you must replace the API placeholder values listed below.

## Features

- Handles authentication to the ConnectWise Manage and Automate REST APIs
- Handles retrieving access token from ConnectWise Automate
- Automatically manages API request paging, no action needed to retrieve over 1000 records
- Option to automatically expand all return columns that contain records
- Support for any condition, filtering, sorting the API supports via query string 
- Able to be pushed to Power BI online and have the dataset automatically refresh


## Parameters

- Product (text) - ConnectWise Product API you will be querying (ex: "manage")
- ApiEndpoint (text) - API endpoint you will be querying (ex: "service/tickets")
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)

## API Placeholders (Replace these with your values, a couple are in multiple spots)

- CWD_CLIENTID - This is your ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
- CWA_USERNAME - Username for integrator account setup in ConnectWise Automate
- CWA_PASSWORD - Password for integrator account setup in ConnectWise Automate
- CWA_API_URL - URL for your ConnectWise Automate instance API (ex: "https://demo.hostedrmm.com/cwa/api/v1/")
- CWM_AUTH - This value is a base64 encoding of YourCWMCompany+YourApiPublicKey:YourApiPrivateKey
- CWM_API_URL - URL to your ConnectWise Manage instance API (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")

## Power BI Online

This function can be used for datasets that are pushed to Power BI Online. The only option you will need to change once you have the dataset in Power BI online, is to modify the authentication settings for the dataset and have it to skip Authentication Checks. Once you have done that, the dataset can be scheduled to refresh automatically.

## Download

[CWApiRequest](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/src/CWApiRequest.pq)

## How To Use

Create a new query in Power BI called CWApiRequest and copy/paste the contents of the file above into the query. Once that's done you can create another query that uses the CWApiRequest function. The samples below show how CWApiRequest can be used.

I would suggest using [Postman](https://www.postman.com/) or an equivalent REST API explorer to build your queries before using them in Power BI, as you will get better error messages with the HTTP responses.

If you have already tried setting up authentication in your PBIX to your ConnectWise REST API instance, remove that as the CWApiRequest function handles authentication to the API.

## Samples

**ConnectWise Manage**
[Get Open Service Tickets](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/SAMPLE_CWM_GetOpenServiceTickets.pq)

**ConnectWise Automate**
[Get Location Computers](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/SAMPLE_CWA_GetLocationComputers.pq)

## ConnectWise REST API Documentation

[ConnectWise Developer](https://developer.connectwise.com/Products/Manage/REST)

## Special Thanks

The basis of this function is based on the work that [Quinntin Comer](https://comertechnology.com/) did for this [article](https://comertechnology.com/cw-manage-getting-started-with-powerbi-the-update/).
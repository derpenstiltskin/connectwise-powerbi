# Power BI Queries for ConnectWise Manage and Automate

These Power Queries will perform requests against the ConnectWise Manage and Automate REST APIs.

## Features

- Handles authentication to the ConnectWise Manage and Automate REST APIs
- Handles retrieving access token from ConnectWise Automate
- Automatically manages API request paging, no action needed to retrieve over 1000 records
- Option to automatically expand all return columns that contain records
- Support for any condition, filtering, sorting the API supports via query string
- Handles query responses with null value fields
- Able to be pushed to Power BI online and have the dataset automatically refresh


## Parameters

- Resource (text) - API resource you will be querying (Manage ex: "service/tickets"; Automate ex: "computers)
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)

## ConnectWise Manage API Placeholders

Replace these with your values.

- _CWMANAGE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
- _CWMANAGE_COMPANY_ - Company value for your ConnectWise Manage instance
- _CWMANAGE_PUBKEY_ - Public key for your ConnectWise Manage API Key
- _CWMANAGE_PRIVKEY_ - Private key for your ConnectWise Manage API Key
- _CWMANAGE_API_URL_ - URL for your ConnectWise Manage API instance (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")

## ConnectWise Automate API Placeholders

Replace these with your values.

- _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
- _CWAUTOMATE_USERNAME_ - Username for an integrator account in ConnectWise Automate
- _CWAUTOMATE_PASSWORD_ - Password for an integrator account in ConnectWise Automate
- _CWAAUTOMATE_API_URL_ - URL for your ConnectWise Automate API instance (ex: "https://demo.hostedrmm.com/cwa/api/v1/")

## Power BI Online

These queries can be used for datasets that are pushed to Power BI Online. The only option you will need to change once you have the dataset in Power BI online, is to modify the authentication settings for the dataset to have it to Skip Authentication Checks. With that set, the dataset can be scheduled to refresh automatically.

## Download

[Project Releases](https://github.com/derpenstiltskin/connectwise-powerbi/releases)

## How To Use

Grab the latest release from above

For ConnectWise Manage Queries:
- Create a query in Power BI called CWManageApiRequest
- Copy/Paste the contents of CWManageApiRequest.pq into the query
- Create a query to call CWManageApiRequest

For ConnectWise Automate Queries:
- Create a query in Power BI called CWAutomateApiRequest
- Copy/Paste the contents of CWAutomateApiRequest.pq into the query
- Create a query to call CWAutomateApiRequest

I would suggest using [Postman](https://www.postman.com/), [Insomnia](https://insomnia.rest/) or an equivalent REST API explorer to build your queries before using them in Power BI, as you will get better error messages for debugging.

If you have already tried setting up authentication in your PBIX to your ConnectWise REST API instance previously, remove that because the CWManageApiRequest and CWAutomateApiRequest queries handle authentication.

## Samples

**ConnectWise Manage**

[Get Open Service Tickets](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CWManage_GetOpenServiceTickets.pq)

**ConnectWise Automate**

[Get Location Computers](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CWAutomate_GetLocationComputers.pq)

## ConnectWise REST API Documentation

[ConnectWise Developer](https://developer.connectwise.com)

## Special Thanks

The basis of this function is based on the work that [Quinntin Comer](https://comertechnology.com/) did for this [article](https://comertechnology.com/cw-manage-getting-started-with-powerbi-the-update/).
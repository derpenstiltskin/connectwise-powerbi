# USAGE

#### Table of Contents
*   [How To Use](#how-to-use)
*   [Power BI Online](#power-bi-online)
*   [Other Notes](#other-notes)

----------

## How To Use

- Generate a ClientId in the (ConnectWise Developer Network)[https://developer.connectwise.com]

### ConnectWise Manage

- Create a Security Role in ConnectWise Manage with permissions required for your queries
- Create an API Member in ConnectWise Manage that is assigned the security role you created
- Generate an API Key and record the public and private keys
- Create a new query in Power BI
- Copy/paste the query from CWManageApiRequest.pq into the query you just created
- Replace the following values with your own:
  - _CWMANAGE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network
  - _CWMANAGE_COMPANY_ - Company value for your ConnectWise Manage instance
  - _CWMANAGE_API_PUBKEY_ - Public key for your ConnectWise Manage API Key
  - _CWMANAGE_API_PRIVKEY_ - Private key for your ConnectWise Manage API Key
  - _CWMANAGE_API_URL_ - URL for your ConnectWise Manage API instance (ex: <https://api-na.myconnectwise.net/v4_6_release/apis/3.0/>)
- Create a new query in Power BI that uses the CWManageApiRequest query (ex: [Get Open Service Tickets](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CWManage_GetOpenServiceTickets.pq))

----------

### CWManageApiRequest Parameters

- Resource (text) - API resource you will be querying (Manage ex: "service/tickets"; Automate ex: "computers)
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)

----------

### ConnectWise Automate

- Create a User Class in ConnectWise Automate with the permission required for your queries
- Create a User in ConnectWise Automate with the Integrator box checked and is assigned the User Class you created
- Create a new query in Power BI
- Copy/paste the query from CWAutomateApiRequest.pq into the query you just created
  - _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network
  - _CWAUTOMATE_USERNAME_ - Username for an integrator account in ConnectWise Automate
  - _CWAUTOMATE_PASSWORD_ - Password for an integrator account in ConnectWise Automate
  - _CWAUTOMATE_API_URL_ - URL for your ConnectWise Automate API instance (ex: <https://demo.hostedrmm.com/cwa/api/v1/>)
- Copy/paste the query from CWAutomateApiTokenRequest.pq into the query you just created
- Replace the following values with your own:
  - _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network
  - _CWAUTOMATE_API_URL_ - URL for your ConnectWise Automate API instance (ex: <https://demo.hostedrmm.com/cwa/api/v1/>)
- Create a new query in Power BI that uses the CWAutomateApiTokenRequest and CWAutomateApiRequest queries (ex: [Get Location Computers](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CWAutomate_GetLocationComputers.pq))

----------

### CWAutomateApiRequest Parameters

- Resource (text) - API resource you will be querying (Manage ex: "service/tickets"; Automate ex: "computers)
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)
- Token (text) - Token returned from CWAutomateApiTokenRequest

----------

### CWAutomateApiTokenRequest Parameters

None

----------

### ConnectWise RMM Modern API

- Generate an API key in the Reporting API page in ConnectWise RMM
- Copy/paste the query from CWRmmApiRequest.pq into the query you just created
  - _CWRMM_API_KEY_ - This is the API key generated in the Reporting API page of RMM
  - _CWRMM_API_URL_ - URL for your ConnectWise RMM Modern API instance (ex: <https://api.itsupport247.net/reporting/v1/>)
- Create a new query in Power BI that uses the CWManageApiRequest query (ex: [Get Sites](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CWRmm_GetSites.pq))

----------

### CWAutomateApiRequest Parameters

- Resource (text) - API resource you will be querying (Manage ex: "service/tickets"; Automate ex: "computers)
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)
- Token (text) - Token returned from CWAutomateApiTokenRequest

----------

## Power BI Online

These queries can be used for datasets that are pushed to Power BI Online. The only option you will need to change once you have the dataset in Power BI online, is to modify the authentication settings for the dataset to have it to Skip Authentication Checks. With that set, the dataset can be scheduled to refresh automatically.

----------

## Other Notes

I would suggest using [Postman](https://www.postman.com/), [Insomnia](https://insomnia.rest/) or an equivalent REST API explorer to build your queries before using them in Power BI, as you will get better error messages for debugging.

If you have already tried setting up authentication in your PBIX to your ConnectWise REST API instance previously, remove that because the CWManageApiRequest and CWAutomateApiRequest queries handle authentication.
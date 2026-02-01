# USAGE

#### Table of Contents
*   [How To Use](#how-to-use)
*   [PowerBI Online](#powerbi-online)
*   [Other Notes](#other-notes)

----------

## How To Use

- Generate a ClientId in the [ConnectWise Developer Network](https://developer.connectwise.com)

### ConnectWise PSA

- Create a Security Role in PSA with permissions required for your queries
- Create an API Member in PSA that is assigned the security role you created
- Generate an API Key and record the public and private keys
- Create a new query in PowerBI
- Copy/paste the query from CwPsaApiRequest.pq into the query you just created
- Replace the following values with your own:
  - _CWPSA_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network
  - _CWPSA_COMPANY_ - Company value for your PSA instance
  - _CWPSA_API_PUBKEY_ - Public key for your PSA API Key
  - _CWPSA_API_PRIVKEY_ - Private key for your PSA API Key
  - _CWPSA_API_URL_ - URL for your PSA API instance (ex: <https://api-na.myconnectwise.net/v4_6_release/apis/3.0/>)
- Create a new query in PowerBI that uses the CwPsaApiRequest query (ex: [Get Open Service Tickets](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CwPsa_GetOpenServiceTickets.pq))

----------

### CwPsaApiRequest Parameters

- Resource (text) - API resource you will be querying (ex: "service/tickets")
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)

----------

### ConnectWise Automate

- Create a User Class in Automate with the permission required for your queries
- Create a User in Automate with the Integrator box checked and is assigned the User Class you created
- Create a new query in PowerBI
- Copy/paste the query from CwAutomateApiRequest.pq into the query you just created
  - _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network
  - _CWAUTOMATE_USERNAME_ - Username for an integrator account in Automate
  - _CWAUTOMATE_PASSWORD_ - Password for an integrator account in Automate
  - _CWAUTOMATE_API_URL_ - URL for your Automate API instance (ex: <https://demo.hostedrmm.com/cwa/api/v1/>)
- Copy/paste the query from CwAutomateApiTokenRequest.pq into the query you just created
- Replace the following values with your own:
  - _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network
  - _CWAUTOMATE_API_URL_ - URL for your Automate API instance (ex: <https://demo.hostedrmm.com/cwa/api/v1/>)
- Create a new query in Power BI that uses the CwAutomateApiTokenRequest and CwAutomateApiRequest queries (ex: [Get Location Computers](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/samples/CwAutomate_GetLocationComputers.pq))

----------

### CwAutomateApiRequest Parameters

- Resource (text) - API resource you will be querying (ex: "computers/computer")
- Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
- ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)
- Token (text) - Token returned from CwAutomateApiTokenRequest

----------

### CwAutomateApiTokenRequest Parameters

None

----------

## PowerBI Online

These queries can be used for datasets that are pushed to PowerBI Online. The only option you will need to change once you have the dataset in PowerBI online, is to modify the authentication settings for the dataset to have it to Skip Authentication Checks. With that set, the dataset can be scheduled to refresh automatically.

----------

## Other Notes

Use a REST API explorer (ex: [Postman](https://www.postman.com/), [Insomnia](https://insomnia.rest/)) to build and test your queries.

If you have already tried setting up authentication in your PBIX to your ConnectWise REST API instance previously, remove that because the CwPsaApiRequest and CwAutomateApiRequest queries handle authentication.
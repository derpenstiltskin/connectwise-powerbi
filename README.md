# Connect Power BI to ConnectWise Manage

## Documentation

This function will query the specified ConnectWise Manage API based on the parameters you pass to the function. It will also automatically handle paging to the API, as the API only allows 1000 responses at a time. To be able to use the CWApiRequest function provided, you must replace the API placeholder values listed below.

### Parameters
- ApiEndpoint (text) - API endpoint you will be querying (ex: "service/tickets")
- Conditions (text) - Conditions to filter your request to the API (ex: "closedFlag=false")
- Fields (text) - Comma delimited, no space, list of fields to return with the response (ex: "id,summary,company")
- OrderBy (text) - The field you want to sort by and the direction (ex: "id desc")
- ExpandColumnRecord (logical) - Set to true if you want the function to automatically expand column records (ex: true)

### API Placeholders (Replace these with your values)
- AUTHORIZATION_VALUE - This value is a base64 encoding of YourCWCompany+YourApiPublicKey:YourApiPrivateKey
- CLIENTID_VALUE - This is a ClientID you register for at https://developer.connectwise.com
- CW_API_URL_VALUE - This is the URL to your ConnectWise instance, including the API (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")

## Download

## Samples
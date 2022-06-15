/*
    CWAutomateApiTokenRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This Power Query will get an access token from the ConnectWise Automate REST API.

    API Placeholders (Replace these with your values)
    - _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
    - _CWAUTOMATE_USERNAME_ - Username for an integrator account in ConnectWise Automate
    - _CWAUTOMATE_PASSWORD_ - Password for an integrator account in ConnectWise Automate
    - _CWAUTOMATE_API_URL_ - URL for your ConnectWise Automate API instance (ex: "https://demo.hostedrmm.com/cwa/api/v1/")
*/

let
    CWAutomateApiTokenRequest = () => let
        ClientId = "_CWAUTOMATE_CLIENTID_",
        Username = "_CWAUTOMATE_USERNAME_",
        Password = "_CWAUTOMATE_PASSWORD_",
        Headers = [
            #"Content-Type" = "application/json",
            #"ClientId" = ClientId
        ],
        RelPath = "apitoken",
        Body = Json.FromValue([
            Username = Username,
            Password = Password
        ]),
        TokenResponse = Json.Document(Web.Contents("_CWAUTOMATE_API_URL_", [
            Headers = Headers,
            RelativePath = RelPath,
            Content = Body
        ])),
        Token = Record.Field(TokenResponse, "AccessToken")
    in
        Token
in
    CWAutomateApiTokenRequest
/*
    CWRmmLegacyApiRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This Power Query will perform requests against the ConnectWise RMM Legacy REST API.

    Parameters
    - Resource (text) - ConnectWire RMM Legacy API endpoint you will be querying (ex: "summary/site")
    - Body (record) - Record of request body parameters to send to the API (ex: [Month = 12, SiteCode = "RMMTestSite", Year = 2022])

    API Placeholders (Replace these with your values)
    - _CWRMM_API_KEY_ - This is API key obtained from the ConnectWise RMM> Integration> Reporting API screen
    - _CWRMM_API_URL_ - URL for your ConnectWise RMM Legacy API (ex: "https://itsapi.itsupport247.net/reportingapi/ReportingAPIService.svc/json/")
*/
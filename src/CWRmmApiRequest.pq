/*
    CWRmmApiRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This Power Query will perform requests against the ConnectWise RMM Modern REST API.

    Parameters
    - Resource (text) - ConnectWire RMM Modern API endpoint you will be querying (ex: "sites")

    API Placeholders (Replace these with your values)
    - _CWRMM_API_KEY_ - This is API key obtained from the ConnectWise RMM> Integration> Reporting API screen
    - _CWRMM_API_URL_ - URL for your ConnectWise RMM Modern API (ex: "https://api.itsupport247.net/reporting/v1/")
*/

let
    CWRmmApiRequest = (Resource as text) => let 
        RequestPage = (R as text) => let
            ApiKey = "_CWRMM_API_KEY_",
            Auth = Binary.ToText(Text.ToBinary(":" & ApiKey), BinaryEncoding.Base64),
            Headers = [
                #"Authorization" = "Basic " & Auth,
                #"Content-Type" = "application/json"
            ],
            RelPath = R,
            RequestPage = Json.Document(Web.Contents("_CWRMM_API_URL_", [Headers = Headers, RelativePath = RelPath]))
        in
            RequestPage,
        DataList = List.Generate(
            () => [Response = try @RequestPage(Resource) otherwise null, PageNumber = 1],
            each [PageNumber] < 2,
            each [Response = try @RequestPage(Resource) otherwise null, PageNumber = [PageNumber] + 1],
            each [Response]
        ),
        DataTable = Table.FromList(DataList, Splitter.SplitByNothing(), {"Column1"}, null, ExtraValues.Error),
        DataTableEx1 = Table.ExpandListColumn(DataTable, "Column1"),
        ColumnContents = Table.Column(DataTableEx1, "Column1"),
        ColumnNames = List.Distinct(List.Combine(List.Transform(ColumnContents,
            each if _ is record then Record.FieldNames(_) else {}))),
        DataTableEx2 = Table.ExpandRecordColumn(DataTableEx1, "Column1", ColumnNames),
        CWRmmApiResponse = DataTableEx2
    in
        CWRmmApiResponse
in
    CWRmmApiRequest
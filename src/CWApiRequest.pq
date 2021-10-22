/*
    CWApiRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This function will query the specified ConnectWise API based on the parameters you pass to the function. To be able to use the CWApiRequest function provided, you must replace the API placeholder values listed below.

    Parameters
    - Product (text) - ConnectWise Product API you will be querying (ex: "manage")
    - ApiEndpoint (text) - API endpoint you will be querying (ex: "service/tickets")
    - Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
    - ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)

    API Placeholders (Replace these with your values, a couple are in multiple spots)
    - CWD_CLIENTID - This is your ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
    - CWA_USERNAME - Username for integrator account setup in ConnectWise Automate
    - CWA_PASSWORD - Password for integrator account setup in ConnectWise Automate
    - CWA_API_URL - URL for your ConnectWise Automate instance API
    - CWM_AUTH - This value is a base64 encoding of YourCWMCompany+YourApiPublicKey:YourApiPrivateKey
    - CWM_API_URL - URL to your ConnectWise Manage instance API (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")
*/

let
    CWApiRequest = (Product as text, ApiEndpoint as text, Query as record, ExpandAll as logical) => let
        CWAApiRequestPage = (CWAApiEndpoint as text, CWAQuery as record, CWAPageNumber as number) => let
            TokenRequestHeaders = [
                #"Content-Type" = "application/json",
                ClientId = "CWD_CLIENTID"
            ],
            TokenRequestRelPath = "apitoken",
            TokenRequestBody = Json.FromValue([
                Username = "CWA_USERNAME",
                Password = "CWA_PASSWORD"
            ]),
            TokenResponse = Json.Document(Web.Contents("CWA_API_URL", [
                Headers = TokenRequestHeaders,
                RelativePath = TokenRequestRelPath,
                Content = TokenRequestBody
            ])),
            Token = Record.Field(TokenResponse, "AccessToken"),
            RequestHeaders = [
                Authorization = "Bearer " & Token,
                #"Content-Type" = "application/json",
                ClientID = "CWD_CLIENTID"
            ],
            CWARelPath = CWAApiEndpoint & Uri.BuildQueryString(CWAQuery) & "&pagesize=1000&page=" & Number.ToText(CWAPageNumber),
            CWAApiRequestPage = Json.Document(Web.Contents("CWA_API_URL", [Headers = RequestHeaders, RelativePath = CWARelPath]))       
        in
            CWAApiRequestPage,
        CWMApiRequestPage = (CWMApiEndpoint as text, CWMQuery as record, CWMPageNumber as number) => let
            RequestHeaders = [
                Authorization = "Basic CWM_AUTH",
                #"Content-Type" = "application/json",
                ClientID = "CWD_CLIENTID"
            ],
            CWMRelPath = CWMApiEndpoint & Uri.BuildQueryString(CWMQuery) & "&pagesize=1000&page=" & Number.ToText(CWMPageNumber),
            CWMApiRequestPage = Json.Document(Web.Contents("CWM_API_URL", [Headers = RequestHeaders, RelativePath = CWMRelPath]))
        in
            CWMApiRequestPage,
        CWApiExpandColumnRecord = (TableToExpand as table, optional ColumnNumber as number) => let
            ActualColumnNumber = if (ColumnNumber = null) 
                then
                    0
                else
                    ColumnNumber,
            ColumnName = Table.ColumnNames(TableToExpand){ActualColumnNumber},
            ColumnContents = Table.Column(TableToExpand, ColumnName),
            ColumnsToExpand = List.Distinct(List.Combine(List.Transform(ColumnContents, 
                each if _ is record then Record.FieldNames(_) else {}))),
            NewColumnNames = List.Transform(ColumnsToExpand, each ColumnName & "." & _),
            CanExpandCurrentColumn = List.Count(ColumnsToExpand) > 0,
            ExpandedTable = if CanExpandCurrentColumn 
                then 
                    Table.ExpandRecordColumn(TableToExpand, ColumnName, ColumnsToExpand, NewColumnNames) 
                else 
                    TableToExpand,
            NextColumnNumber = if CanExpandCurrentColumn
                then
                    ActualColumnNumber
                else
                    ActualColumnNumber + 1,
            CWApiExpandedTable = if NextColumnNumber > (Table.ColumnCount(ExpandedTable) - 1) 
                then 
                    ExpandedTable 
                else 
                    @CWApiExpandColumnRecord(ExpandedTable, NextColumnNumber)
        in
            CWApiExpandedTable,
        DataList = if (Product = "automate") then
            List.Generate(
                () => [Result = try @CWAApiRequestPage(ApiEndpoint, Query, 1) otherwise null, PageNumber = 1],
                each List.Count([Result]) > 0,
                each [Result = try @CWAApiRequestPage(ApiEndpoint, Query, [PageNumber] + 1) otherwise null, PageNumber = [PageNumber] + 1], 
                each [Result])
        else if (Product = "manage") then
            List.Generate(
                () => [Result = try @CWMApiRequestPage(ApiEndpoint, Query, 1) otherwise null, PageNumber = 1],
                each List.Count([Result]) > 0,
                each [Result = try @CWMApiRequestPage(ApiEndpoint, Query, [PageNumber] + 1) otherwise null, PageNumber = [PageNumber] + 1], 
                each [Result])
        else
            null,
        DataTable = Table.FromList(DataList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        DataTableEx1 = Table.ExpandListColumn(DataTable, "Column1"),
        DataTableEx2 = Table.ExpandRecordColumn(DataTableEx1, "Column1", Record.FieldNames(Table.First(DataTableEx1)[Column1])),
        CWApiResponse = if (ExpandAll = true) 
            then
                @CWApiExpandColumnRecord(DataTableEx2)
            else
                DataTableEx2
    in
        CWApiResponse
in
    CWApiRequest
/*
    CWApiRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This function will query the specified ConnectWise Manage API based on the parameters you pass to the function. You must replace the placeholder values listed below.

    Parameters
    - ApiEndpoint (text) - API endpoint you will be querying (ex: "service/tickets")
    - Conditions (text) - Conditions to filter your request to the API (ex: "closedFlag=false")
    - Fields (text) - Comma delimited, no space, list of fields to return with the response (ex: "id,summary,company")
    - OrderBy (text) - The field you want to sort by and the direction (ex: "id desc")
    - ExpandColumnRecord (logical) - Set to true if you want the function to automatically expand column records (ex: true)

    API Placeholders (Replace these with your values)
    - AUTHORIZATION_VALUE - This value is a base64 encoding of YourCWCompany+YourApiPublicKey:YourApiPrivateKey
    - CLIENTID_VALUE - This is a ClientID you register for at https://developer.connectwise.com
    - CW_API_URL_VALUE - This is the URL to your ConnectWise instance, including the API (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")
*/

let
    CWApiRequest = (ApiEndpoint as text, Conditions as text, Fields as text, OrderBy as text, ExpandColumnRecords as logical) => let
        CWApiRequestPage = (PageApiEndpoint as text, PageConditions as text, PageFields as text, PageOrderBy as text, PageNumber as number) => let
            RequestHeaders = [
                Authorization = "Basic AUTHORIZATION_VALUE",
                clientID = "CLIENTID_VALUE",
                ContentType="JSon"
            ],
            RequestRelPath = PageApiEndpoint & "?conditions=" & PageConditions & "&fields=" & PageFields & "&orderby=" & PageOrderBy & "&pagesize=1000&page=" & Number.ToText(PageNumber),
            Response = Json.Document(Web.Contents("CW_API_URL_VALUE", [Headers = RequestHeaders, RelativePath = RequestRelPath]))
        in 
            Response,
        CWApiExpandColumnRecord = (TableToExpand as table, optional ColumnNumber as number) => let
            ActualColumnNumber = if (ColumnNumber = null) then 0 else ColumnNumber,
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
            NextColumnNumber = if CanExpandCurrentColumn then ActualColumnNumber else ActualColumnNumber + 1,
            OutputTable = if NextColumnNumber > (Table.ColumnCount(ExpandedTable) - 1) 
                then 
                    ExpandedTable 
                else 
                    @CWApiExpandColumnRecord(ExpandedTable, NextColumnNumber)
        in
            OutputTable,
        DataList = List.Generate(
            () => [Result = try @CWApiRequestPage(ApiEndpoint, Conditions, Fields, OrderBy, 1) otherwise null, PageNumber = 1],
            each List.Count([Result]) > 0,
            each [Result = try @CWApiRequestPage(ApiEndpoint, Conditions, Fields, OrderBy, [PageNumber] + 1) otherwise null, PageNumber = [PageNumber] + 1], 
            each [Result]),
        DataTable = Table.FromList(DataList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        DataTableEx1 = Table.ExpandListColumn(DataTable, "Column1"),
        DataTableEx2 = Table.ExpandRecordColumn(DataTableEx1, "Column1", Text.Split(Fields, ",")),
        Response = if (ExpandColumnRecords = true) 
            then
                @CWApiExpandColumnRecord(DataTableEx2)
            else
                DataTableEx2
    in
        Response
in
    CWApiRequest
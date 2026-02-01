/*
    CwAutomateApiRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This Power Query will perform requests against the ConnectWise Automate REST API.

    Parameters
    - Resource (text) - ConnectWire Automate API endpoint you will be querying (ex: "computers/drives")
    - Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
    - ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)
    - Token (text) - API token from running CwAutomateApiTokenRequest()

    API Placeholders (Replace these with your values)
    - _CWAUTOMATE_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
    - _CWAUTOMATE_API_URL_ - URL for your ConnectWise Automate API instance (ex: "https://demo.hostedrmm.com/cwa/api/v1/")
*/

let
    CwAutomateApiRequest = (Resource as text, Query as record, ExpandAll as logical, Token as text) => let
        RequestPage = (R as text, Q as record, PN as number) => let
            ClientId = "_CWAUTOMATE_CLIENTID_",
            Headers = [
                #"Authorization" = "Bearer " & Token,
                #"Content-Type" = "application/json",
                #"ClientId" = ClientId
            ],
            RelPath = R & "?" & Uri.BuildQueryString(Q) & "&pagesize=1000&page=" & Number.ToText(PN),
            RequestPage = Json.Document(Web.Contents("_CWAUTOMATE_API_URL_", [Headers = Headers, RelativePath = RelPath]))
        in
            RequestPage,
        ExpandColumnRecord = (TableToExpand as table, optional ColumnNumber as number) => let
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
            ExpTable = if CanExpandCurrentColumn
                then
                    Table.ExpandRecordColumn(TableToExpand, ColumnName, ColumnsToExpand, NewColumnNames)
                else
                    TableToExpand,
            NextColumnNumber = if CanExpandCurrentColumn
                then
                    ActualColumnNumber
                else
                    ActualColumnNumber + 1,
            ExpandedTable = if NextColumnNumber > (Table.ColumnCount(ExpTable) - 1)
                then
                    ExpTable
                else
                    @ExpandColumnRecord(ExpTable, NextColumnNumber)
        in
            ExpandedTable,
        DataList = List.Generate(
            () => [Response = try @RequestPage(Resource, Query, 1) otherwise null, PageNumber = 1],
            each List.Count([Response]) > 0,
            each [Response = try @RequestPage(Resource, Query, [PageNumber] + 1) otherwise null, PageNumber = [PageNumber] + 1],
            each [Response]
        ),
        DataTable = Table.FromList(DataList, Splitter.SplitByNothing(), {"Column1"}, null, ExtraValues.Error),
        DataTableEx1 = Table.ExpandListColumn(DataTable, "Column1"),
        ColumnContents = Table.Column(DataTableEx1, "Column1"),
        ColumnNames = List.Distinct(List.Combine(List.Transform(ColumnContents,
                each if _ is record then Record.FieldNames(_) else {}))),
        DataTableEx2 = Table.ExpandRecordColumn(DataTableEx1, "Column1", ColumnNames),
        CwAutomateApiResponse = if (ExpandAll = true)
            then
                @ExpandColumnRecord(DataTableEx2)
            else
                DataTableEx2
    in
        CwAutomateApiResponse
in
    CwAutomateApiRequest
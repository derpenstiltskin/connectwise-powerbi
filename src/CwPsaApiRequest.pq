/*
    CwPsaApiRequest
    Author: Dustin Riley <dustin@derpenstiltskin.com>
    Git Repo: https://github.com/derpenstiltskin/connectwise-powerbi

    Documentation
    -------------

    This Power Query will perform requests against the ConnectWise PSA REST API.

    Parameters
    - Resource (text) - ConnectWise PSA API endpoint you will be querying (ex: "service/tickets")
    - Query (record) - Record of query string parameters to send to the API (ex: [conditions='closedFlag=false'])
    - ExpandAll (logical) - Set to true if you want column records automatically expanded (ex: true)

    API Placeholders (Replace these with your values)
    - _CWPSA_CLIENTID_ - This is the ClientID obtained from the ConnectWise Developer Network: https://developer.connectwise.com
    - _CWPSA_COMPANY_ - Company value for your ConnectWise PSA instance
    - _CWPSA_API_PUBKEY_ - Public key for your ConnectWise PSA API Key
    - _CWPSA_API_PRIVKEY_ - Private key for your ConnectWise PSA API Key
    - _CWPSA_API_URL_ - URL for your ConnectWise PSA API instance (ex: "https://api-na.myconnectwise.net/v4_6_release/apis/3.0/")
*/

let
    CwPsaApiRequest = (Resource as text, Query as record, ExpandAll as logical) => let
        RequestPage = (R as text, Q as record, PN as number) => let
            ClientId = "_CWPSA_CLIENTID_",
            Company = "_CWPSA_COMPANY_",
            PublicKey = "_CWPSA_API_PUBKEY_",
            PrivateKey = "_CWPSA_API_PRIVKEY_",
            Auth = Binary.ToText(Text.ToBinary(Company & "+" & PublicKey & ":" & PrivateKey), BinaryEncoding.Base64),
            Headers = [
                #"Authorization" = "Basic " & Auth,
                #"Content-Type" = "application/json",
                #"ClientId" = ClientId
            ],
            RelPath = R & "?" & Uri.BuildQueryString(Q) & "&pagesize=1000&page=" & Number.ToText(PN),
            RequestPage = Json.Document(Web.Contents("_CWPSA_API_URL_", [Headers = Headers, RelativePath = RelPath]))
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
        CwPsaApiResponse = if (ExpandAll = true)
            then
                @ExpandColumnRecord(DataTableEx2)
            else
                DataTableEx2
    in
        CwPsaApiResponse
in
    CwPsaApiRequest
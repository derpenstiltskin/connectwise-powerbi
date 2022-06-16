/*
    This example will take a while to run, since it has to run a query against
    each drive id to retrieve it's stats.
*/
let 
    DriveHealth = let
        Token = CWAutomateApiTokenRequest(),
        Computers = CWAutomateApiRequest(
            "computers",
            [
                includefields = "Id,ComputerName"
            ],
            true,
            Token
        ),
        ComputersIndexed = Table.TransformColumnTypes(Computers, {"Id", type number}),
        Drives = CWAutomateApiRequest(
            "computers/drives",
            [
                includefields = "DriveId,ComputerId"
            ],
            true,
            Token),
        DrivesIndexed = Table.TransformColumnTypes(Drives, {{"ComputerId", type number},{"DriveId", type number}}),
        ComputerDrives = Table.RemoveColumns(Table.Join(ComputersIndexed, "Id", DrivesIndexed, "ComputerId", JoinKind.FullOuter), "Id"),
        DriveHealthList = List.RemoveNulls(List.Generate(
            () => [Response = try CWAutomateApiRequest("drives/"&Number.ToText(ComputerDrives{0}[DriveId])&"/drivestats/daily", [], true, Token) otherwise null, RowNumber = 0],
            each [RowNumber] < Table.RowCount(ComputerDrives),
            each [Response = try CWAutomateApiRequest("drives/"&Number.ToText(ComputerDrives{RowNumber}[DriveId])&"/drivestats/daily", [], true, Token) otherwise null, RowNumber = [RowNumber] + 1],
            each [Response])),
        DriveHealth = Table.FromList(DriveHealthList, Splitter.SplitByNothing(), {"Column1"}, null, ExtraValues.Error),
        DriveHealthEx1 = Table.ExpandListColumn(DriveHealth, "Column1"),
        ColumnContents = Table.Column(DriveHealthEx1, "Column1"),
        ColumnNames = List.Distinct(List.Combine(List.Transform(ColumnContents,
                each if _ is record then Record.FieldNames(_) else {}))),
        DriveHealthEx2 = Table.ExpandRecordColumn(DriveHealthEx1, "Column1", ColumnNames),
        DriveHealthIndexed = Table.TransformColumnTypes(DriveHealthEx2, {"DriveId", type number}),
        DriveHealthFinal = Table.NestedJoin(ComputerDrives, "DriveId", DriveHealthIndexed, "DriveId", "Health")
    in
        DriveHealthFinal
in
    DriveHealth
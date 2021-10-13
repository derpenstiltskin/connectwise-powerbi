let 
    OpenServiceTickets = let 
        ApiEndpoint = "service/tickets",
        Conditions = "closedFlag=false",
        Fields = "id,summary,company",
        OrderBy = "id asc",
        ExpandColumnRecords = true,
        Response = CWApiRequest(ApiEndpoint, Conditions, Fields, OrderBy, ExpandColumnRecords)
    in
        Response
in
    OpenServiceTickets
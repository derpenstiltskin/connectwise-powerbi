let 
    OpenServiceTickets = let 
        ApiEndpoint = "service/tickets",
        Conditions = "closedFlag=false",
        Fields = "id,summary,company",
        OrderBy = "id asc",
        Response = CWApiRequest(ApiEndpoint, Conditions, Fields, OrderBy, true)
    in
        Response
in
    OpenServiceTickets
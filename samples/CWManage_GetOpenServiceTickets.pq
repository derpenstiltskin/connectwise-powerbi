let 
    OpenServiceTickets = let
        Response = CWManageApiRequest(
            "service/tickets",
            [
                conditions = "closedFlag=false",
                fields = "id,summary,company",
                orderBy = "id asc"                 
            ],
            true)
    in
        Response
in
    OpenServiceTickets
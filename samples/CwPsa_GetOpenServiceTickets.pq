let 
    OpenServiceTickets = let
        Response = CwPsaApiRequest(
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
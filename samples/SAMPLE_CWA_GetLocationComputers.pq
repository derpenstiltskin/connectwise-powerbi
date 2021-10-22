let 
    LocationComputers = let
        Response = CWApiRequest(
            "automate",
            "computers",
            [
                condition = "location.name='Trenzalore'",
                includefields = "id,computername,location",
                orderby = "computername asc"
            ],
            true)
    in
        Response
in
    LocationComputers
let 
    LocationComputers = let
        Response = CWAutomateApiRequest(
            "computers",
            [
                condition = "location.name='Home Office'",
                includefields = "id,computername,location",
                orderby = "computername asc"
            ],
            true)
    in
        Response
in
    LocationComputers
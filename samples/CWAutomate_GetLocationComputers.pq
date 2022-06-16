let 
    LocationComputers = let
        Token = CWAutomateApiTokenRequest(),
        Response = CWAutomateApiRequest(
            "computers",
            [
                condition = "location.name='Home Office'",
                includefields = "id,computername,location",
                orderby = "computername asc"
            ],
            true,
            Token)
    in
        Response
in
    LocationComputers
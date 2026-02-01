let 
    LocationComputers = let
        Token = CwAutomateApiTokenRequest(),
        Response = CwAutomateApiRequest(
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
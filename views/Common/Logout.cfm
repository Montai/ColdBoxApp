<cfsilent>
    <cflock scope = "Session" type = "Readonly" timeout = "20">
        <cfset variables.sessionItems = "#StructKeyList(Session)#">
    </cflock>
    <cfloop index = "ListElement" list = "#variables.sessionItems#">
        <cfif listFindNoCase("CFID,CFToken,URLToken,SessionID", "#ListElement#") is 0 >
            <cflock scope = "Session" type = "Exclusive" timeout = "20">
                <cfset StructDelete(Session, "#ListElement#")>
            </cflock>
        </cfif>
    </cfloop>
    <cflocation url = "LoginPage.cfm" addtoken = "false">
</cfsilent>

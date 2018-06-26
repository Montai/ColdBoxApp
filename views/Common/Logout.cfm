<!--- File Name: Logout.cfm
    Description: It is the logout page action page
--->
<cflock scope = "Session" type = "Readonly" timeout = "20">
    <cfset variables.sessionItems = "#StructKeyList(Session)#">
</cflock>
<cfdump var = "#Session#" abort = "false">

<cfloop index = "ListElement" list = "#variables.sessionItems#">
        <cflock scope = "Session" type = "Exclusive" timeout = "20">
            <cfdump var = "#ListElement#" abort = "false">
            <cfset StructDelete(Session, "#ListElement#")>
        </cflock>
</cfloop>

<cflocation url = "../../index.cfm" addtoken = "false">


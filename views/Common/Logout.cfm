<!--- File Name: Logout.cfm
    Description: It is the logout page action page
	Author: saura
--->
<cflock scope = "Session" type = "Readonly" timeout = "20">
    <cfset variables.sessionItems = "#StructKeyList(Session)#">
</cflock>


<!--- <cfloop index = "ListElement" list = "#variables.sessionItems#"> --->
      <!---<cflock scope = "Session" type = "Exclusive" timeout = "20">
          <cfdump var = "#ListElement#" abort = "false">
          <cfset StructDelete(Session, "#ListElement#")>
      </cflock>--->
<cflock scope = "Session" type = "Exclusive" timeout = "20">
	<cfset StructClear(Session)>
</cflock>
<!--- <cfdump var = "#Session#" abort = "yes"> --->
<!--- </cfloop> --->

<cflocation url = "../../index.cfm" addtoken = "false">


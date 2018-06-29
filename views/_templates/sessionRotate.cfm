<cfif isDefined("url.rotate") >
<cfset sessionRotate()/>
</cfif>
<cfif isDefined("url.name") >
<cfset session.name = url.name />
</cfif>
<cfdump var="#session#" label="SESSION">
<cfoutput>
<a href="sessionRotate.cfm?name=BOB">Set session.name = BOB </a> <br/>
<a href="sessionRotate.cfm?rotate=TRUE">Rotate the session</a>
</cfoutput>
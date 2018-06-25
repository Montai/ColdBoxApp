<!--- File name: OnError.cfc
Description: Handles the error and shows it 
--->
<h1>Exception Occured</h1>
<cfoutput>
    <p> #encodeForHTML(rc.error)# </p>
    <p><a href = "../../../coldboxapp/index.cfm">Login</a></p>
</cfoutput>
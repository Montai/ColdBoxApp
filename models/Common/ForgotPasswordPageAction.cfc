<cfcomponent displayname = "" hint = "">
    <cffunction  name = "sendEmailToUser" returntype = "string" access = "public">
        <cftry>
            <cfset var result="">
            <cfset var i=0>

            <!--- Create string --->
            <cfloop index="i" from="1" to="#20#">
                <!--- Random character in range A-Z --->
                <cfset result = result & Chr(RandRange(65, 90))>
            </cfloop>
            <!--- Send mail to user --->
            <cfmail  from = "from@smtp.com"  subject = "subject"  to = "#form.emailId#">
                Email sent successfully!
            </cfmail>
            <cfquery name = "insertNewPassword">
                UPDATE Users
                SET PASSWORD = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#result#">
                WHERE EMAILID = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.emailId#">
            </cfquery>
            <cfreturn "true">
        <cfcatch type = "exception">
            <cfreturn "false">
        </cfcatch>
        </cftry>
    </cffunction>
</cfcomponent>
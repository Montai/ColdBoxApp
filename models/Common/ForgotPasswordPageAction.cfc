<!--- File name: ForgotPasswordPageAction.cfc
    Description: Send a random password via mail to users account
	Author: saura
 --->
<cfcomponent displayname = "Forgot Password Action" hint = "handles the forgot password">
    <!--- Function name: sendEmailToUser
          Description: User being asked to enter email, and password is being sent
    --->
    <cffunction  name = "sendEmailToUser" returntype = "string" access = "public">
        <cftry>
            <cfif form.emailId EQ "">
                <cfreturn "Email is blank">
            </cfif>
            <cfif NOT isValid("email", form.emailId)>
                <cfreturn "Invalid email format. Email must be in format(abc@xyz.com)">
            </cfif>
            <cfquery name = "checkUserEmail">
                SELECT EMAILID
                FROM Users
                WHERE EMAILID = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.emailId#">
            </cfquery>
            <cfif checkUserEmail.RecordCount EQ 0>
                <cfreturn "No such email exist, please try again">
            </cfif>
            <cfset var result = "">
            <cfset var i = 0>

            <!--- Create string --->
            <cfloop index="i" from="1" to="#10#">
                <!--- Random character in range A-Z --->
                <cfset result = result & Chr(RandRange(65, 90))>
            </cfloop>
            <!--- Send mail to user --->
            <cfmail  from = "montai@domain.com"  to = "#form.emailId#" subject = "Send email to user">
                Email sent successfully! Your new password is: "#result#"
            </cfmail>
            <!--- Encrypt the password --->
            <cfset local.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
		    <cfset local.hashedPassword = Hash("#result#" & salt, "SHA-512") />
            <cfquery name = "insertNewPassword">
                UPDATE Users
                SET PASSWORD = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#hashedPassword#">
                WHERE EMAILID = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.emailId#">
            </cfquery>
            <cfreturn "true">
        <cfcatch type = "exception">
            <cfreturn "Unable to send mail">
        </cfcatch>
        </cftry>
    </cffunction>
</cfcomponent>
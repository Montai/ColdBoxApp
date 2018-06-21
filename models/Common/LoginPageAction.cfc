<!--- File Name: LoginPageAction.cfc
	  Description: It validates the login form and check form data --->
<cfcomponent name = "LoginAction" hint = "Validates and insert data in db">
	<!--- Function Name: validateLoginForm.cfc
		  Description: Does the validation of form variables
	--->
	<cffunction name = "validateLoginForm" description = "Check form values" hint = "Validate data" returntype = "boolean" access = "public" output = "false">
		<cfargument name = "email" type = "string" required = "true">
		<cfargument name = "password" type = "string" required = "true">
		<cfset variables.flag = true>
		<cfset variables.myArray = ArrayNew(1)>
		<cfif not isValid("email", arguments.email)>
			<cfset variables.flag = false>
		</cfif>
		<cfif len(arguments.password) GTE 6
					AND len(arguments.password) LTE 20 >
		<cfelse>
			<cfset variables.flag = false>
		</cfif>
		<cfreturn variables.flag>
	</cffunction>
	<!--- name: checkFormData 
		  description: It find the matching password and check its existance in db
	--->
	<cffunction name = "checkFormData" description = "Check the password" returntype = "string" hint = "check credentials" access = "public" output = "false">
		<cfargument name = "email" type = "string" required = "true" />
		<cfargument name = "password" type = "string" required = "true" />
		<cftry>
			<cfquery name = "request.getPwdAndSalt">
				SELECT PASSWORD, SALT, ID
				FROM Users
				WHERE EMAILID = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#arguments.email#">
			</cfquery>
			<!--- <cfdump var = "#request.getPwdAndSalt.RecordCount#" abort = "true"> --->
			<!--- If the record exist in database --->
			<cfif request.getPwdAndSalt.RecordCount EQ 1>
				<cfif request.getPwdAndSalt.PASSWORD EQ Hash(arguments.password & request.getPwdAndSalt.SALT, "SHA-512")>
					<!--- Setting user session --->
					<cfset Session.user = request.getPwdAndSalt.ID >
					<cfreturn "true">
				<cfelse>
					<cfreturn "false">
				</cfif>
			</cfif>
			<cfif request.getPwdAndSalt.RecordCount NEQ 1>
				<cfreturn "Invalid Email or Password">
			</cfif>
			<cfcatch type = "any">
				<cfreturn "Opps, database exception occured">
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>

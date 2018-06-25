<!--- File Name: LoginPageAction.cfc
	  Description: It validates the login form and check form data --->
<cfcomponent displayname = "LoginAction" hint = "Validates and insert data in db">

	<!--- Function Name: validateLoginForm.cfc
		  Description: Does the validation of form variables	--->

	<cffunction name = "validateLoginForm" description = "Check form values" hint = "Validate data" returntype = "Array" access = "public" output = "false">
		<cfset local.errorArray = ArrayNew(1)>
		<cfif "#form.emailid#" EQ "">
			<cfset arrayAppend(errorArray, "Email is blank")>
		<cfelseif not isValid("email", "#form.emailid#")>
			<cfset arrayAppend(errorArray,"Invalid email format. Email format(abc@xyz.com)")>
		</cfif>
		<cfif "#form.password#" EQ "">
			<cfset arrayAppend(errorArray, "Password is blank")>
		<cfelseif NOT(len("#form.password#") GTE 6 AND len("#form.password#") LTE 20)>
			<cfset arrayAppend(errorArray, "Password must contain at least 6 and at most 20 characters long")>
		</cfif>
		
		<cfif NOT (arrayIsEmpty(errorArray))>
			<cfreturn local.errorArray>
		<cfelse>
			<cfset local.userFormData = checkFormData() >
			<cfif local.userFormData EQ "true">
				<cfset arrayAppend(errorArray, "true")>
				<cfreturn errorArray>
			<cfelse>
				<cfset arrayAppend(errorArray, userFormData)>
				<cfreturn errorArray>
			</cfif>
		</cfif>
		
	</cffunction>
	<!--- Function name: checkFormData
		  description: It find the matching password and check its existance in db
	--->
	<cffunction name = "checkFormData" description = "Check the password" returntype = "string" hint = "check credentials" access = "public" output = "false">
		<cftry>
			<cfquery name = "request.getPwdAndSalt">
				SELECT PASSWORD, SALT, ID
				FROM Users
				WHERE EMAILID = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.emailid#">
			</cfquery>
			<!--- If the record exist in database --->
			<cfif request.getPwdAndSalt.RecordCount EQ 1>
				<cfif request.getPwdAndSalt.PASSWORD EQ Hash("#form.password#" & request.getPwdAndSalt.SALT, "SHA-512")>
					<!--- Setting user session --->
					<cfset Session.user = request.getPwdAndSalt.ID >
					<cfreturn "true">
				<cfelse>
					<cfreturn "Wrong password or User Name doesn't exist. Create a new one">
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

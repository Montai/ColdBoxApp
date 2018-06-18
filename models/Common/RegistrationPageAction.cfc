<cfcomponent name = "Registration Page Action" hint = "Validates Reg form and insert data in db">
	<cffunction name = "validateRegistrationForm" returntype = "string" output = "true">
		<cftry>
			<cfquery name = "getEmail" datasource = "cfartgallery">
				SELECT EMAILID
				FROM Users
				WHERE EMAILID = '#form.emailId#'
			</cfquery>
		<cfcatch type = "any">
			<!--- <cflocation  url = "/Common/OnError"> --->
			<cfreturn "Email already exists">
		</cfcatch>
		</cftry>
		

		<cfif not isValid("regex", form.firstName, "^[a-zA-Z]*$")>
			<cfreturn "Invalid First Name">
		<cfelseif form.MiddleName NEQ "" and not isValid("regex", form.middleName, "^[a-zA-Z]*$")>
			<cfreturn "Invalid Middle Name">
		<cfelseif not isValid("regex", form.lastName, "^[a-zA-Z]*$")>
			<cfreturn "Invalid Last Name">
		<cfelseif not (form.userGender EQ "male" or form.userGender EQ "female")>
			<cfreturn "Invalid Gender">
		<cfelseif not isValid("date", form.birthDate)>
			<cfreturn "Invalid DateOfBirth">
		<cfelseif not(len(form.address) GTE 10 AND len(form.address) LTE 100)>
			<cfreturn "Invalid Address">
		<cfelseif not(len(form.phoneNumber) EQ 10)>
			<cfreturn "Invalid Phone Number">
		<cfelseif not isValid("email", form.emailId)>
			<cfreturn "Invalid Email">
		<cfelseif not "#getEmail.EMAILID#" EQ "">
			<cfreturn "Email Already Exists">
		<cfelseif not(len(form.password) GTE 6 AND len(form.password) LTE 20)>
			<cfreturn "Invalid Password">
		<cfelseif not(len(form.confirmPassword) GTE 6 AND len(form.confirmPassword) LTE 20)>
			<cfreturn "Invalid Confirm password">
		</cfif>
		<cfreturn "true">
	</cffunction>

	<cffunction name = "insertDataRegistrationForm" returntype = "boolean" output = "false">
		<!--- <cfargument name = "firstName" type = "string" required = "true"> --->
<!--- 		<cfargument name = "middleName" type = "string" required = "false"> --->
<!--- 		<cfargument name = "lastName" type = "string" required = "true"> --->
<!--- 		<cfargument name = "gender" type = "string" required = "true"> --->
<!--- 		<cfargument name = "dateOfBirth" type = "date" required = "true"> --->
<!--- 		<cfargument name = "address" type = "string" required = "true"> --->
<!--- 		<cfargument name = "phoneNumber" type = "string" required = "true"> --->
<!--- 		<cfargument name = "email" type = "string" required = "true"> --->
<!--- 		<cfargument name = "password" type = "string" required = "true"> --->
<!--- 		<cfargument name = "confirmPassword" type = "string" required = "true"> --->

		<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
		<cfset variables.hashedPassword = Hash(form.password & variables.salt, "SHA-512") />
		<!--- insert both variables.salt and variables.hashedPassword into table --->
		<cftry>
			<cfquery name = "insertData" datasource = "cfartgallery">
				INSERT INTO Users(FIRSTNAME, MIDDLENAME, LASTNAME, GENDER, DATEOFBIRTH, ADDRESS, PHONENUMBER, EMAILID, PASSWORD, CONFIRMPASSWORD, SALT)
				VALUES (<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.firstName#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.middleName#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.lastName#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.userGender#">,
						<cfqueryparam cfsqltype = "cf_sql_date" value = "#form.birthDate#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.address#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.phoneNumber#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.emailId#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#variables.hashedPassword#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#variables.hashedPassword#">,
						<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#variables.salt#"> )
			</cfquery>
			<cfcatch type = "any">
				<cflocation  url = "/Common/OnError">
			</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
</cfcomponent>
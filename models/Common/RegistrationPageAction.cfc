<!--- Filename: RegistrationPageAction.cfc
	 Description: Validates the registration page and insert the data
	 Author: saura
	 date created: 11/6/18 --->
<cfcomponent displayname = "Registration Page Action" hint = "Validates Reg form and insert data in db">
	<!--- Method name: validate Registration form
		  Description: It does the server side validation --->
	<cffunction name = "validateRegistrationForm"
				hint = "validates the registration form"
				returntype = "Array"
				access = "public"
				output = "false">
		<cfset local.errorArray = ArrayNew(1)>
		<cftry>
			<cfquery name = "getEmail">
				SELECT EMAILID
				FROM Users
				WHERE EMAILID = '#form.emailId#'
			</cfquery>
		<cfcatch type = "any">
			<cfset arrayAppend(errorArray, "Email already exists, please login")>
		</cfcatch>
		</cftry>
		<cfif form.firstName EQ "">
			<cfset arrayAppend(errorArray, "First name is blank")>
		</cfif>
		<cfif form.lastName EQ "">
			<cfset arrayAppend(errorArray, "Last name is blank")>
		</cfif>
		<cfif form.address EQ "">
			<cfset arrayAppend(errorArray, "Address is blank")>
		</cfif>
		<cfif form.phoneNumber EQ "">
			<cfset arrayAppend(errorArray, "Phone number is blank")>
		</cfif>
		<cfif form.emailId EQ "">
			<cfset arrayAppend(errorArray, "Email id is blank")>
		</cfif>
		<cfif form.password EQ "">
			<cfset arrayAppend(errorArray, "Password is blank")>
		</cfif>
		<cfif len(form.firstName) LTE 2 AND len(form.firstName) GTE 20>
			<cfset arrayAppend(errorArray, "First name should contain atleast 2 and at max 20 characters")>
		</cfif>
		<cfif not isValid("regex", form.firstName, "^[a-zA-Z]*$")>
			<cfset arrayAppend(errorArray, "First Name should contain only letters")>
		</cfif>
		<cfif form.middleName NEQ "" and not isValid("regex", form.middleName, "^[a-zA-Z]*$")>
			<cfset arrayAppend(errorArray, "Middle Name should contain only letters")>
		</cfif>
		<cfif len(form.lastName) LTE 2 AND len(form.lastName) GTE 20>
			<cfset arrayAppend(errorArray, "Last Name should contain only letters")>
		</cfif>
		<cfif not isValid("regex", form.lastName, "^[a-zA-Z]*$")>
			<cfset arrayAppend(errorArray, "Last Name should contain only letters")>
		</cfif>
		<cfif not (form.userGender EQ "male" or form.userGender EQ "female")>
			<cfset arrayAppend(errorArray, "Invalid Gender")>
		</cfif>
		<cfif not isValid("date", form.birthDate)>
			<cfset arrayAppend(errorArray, "Choose a valid date of birth")>
		</cfif>
		<cfif not(len(form.address) GTE 10 AND len(form.address) LTE 100)>
			<cfset arrayAppend(errorArray, "Address must be between 10 to 100 characters")>
		</cfif>
		<cfif not(len(form.phoneNumber) EQ 10)>
			<cfset arrayAppend(errorArray, "Phone Number should have 10 digits")>
		</cfif>
		<cfif not isValid("email", form.emailId)>
			<cfset arrayAppend(errorArray, "Invalid email format. Email format(abc@xyz.com)")>
		</cfif>
		<cfif not "#getEmail.EMAILID#" EQ "">
			<cfset arrayAppend(errorArray, "Email already exists")>
		</cfif>
		<cfif not(len(form.password) GTE 6 AND len(form.password) LTE 20)>
			<cfset arrayAppend(errorArray, "Invalid Password, password must be between 6 to 20 characters")>
		</cfif>
		<cfif not(len(form.confirmPassword) GTE 6 AND len(form.confirmPassword) LTE 20)>
			<cfset arrayAppend(errorArray, "Invalid Confirm password, password must be between 6 to 20 characters")>
		</cfif>
		<cfreturn errorArray>
	</cffunction>

	<!--- Method name: insert data Registration form
		  description: Inserts the data in db --->
	<cffunction name = "insertDataRegistrationForm"
				returntype = "boolean"
				access = "public"
				output = "false">

		<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
		<cfset variables.hashedPassword = Hash(form.password & variables.salt, "SHA-512") />
		<!--- insert both variables.salt and variables.hashedPassword into table --->
		<cftry>
			<cfquery name = "insertData">
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
			<!--- Send a welcome e-mail --->
			<cfmail from = "montai@domain.com" to = "saura.mandal1@gmail.com" subject = "Welcome email sent with ColdFusion">
   				Hello, Your account has been created! Please login back to continue.
			</cfmail>
			<cfcatch type = "any">
				<cfreturn false>
			</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
</cfcomponent>
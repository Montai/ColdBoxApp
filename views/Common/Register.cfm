<!DOCTYPE html>
<head>
 	<link rel="stylesheet" href = "../includes/css/form_style.css">
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
</head>
<body>
	<div class = "formcontainer">
		<cfform onsubmit = "return validateForm()" method = "post">
			<table>
				<tr>
					<div class = "field">
						<td>First Name:</td>
						<td><cfinput type = "text" name = "firstName" class = "input-field" id = "firstName" placeholder = "Enter first Name"></td>
						<td><div class = "errorfield" id = "firstNameError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Middle Name: </td>
						<td><cfinput type = "text" name = "middleName" class = "input-field" id = "middleName" placeholder = "Enter middle Name"></td>
						<td><div class = "errorfield" id = "middleNameError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Last Name: </td>
						<td><cfinput type = "text" name = "lastName" class = "input-field" id = "lastName" placeholder = "Enter last name"></td>
						<td><div class = "errorfield" id = "lastNameError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
					<td>Gender:</td>
					<td>
						<cfselect name = "userGender" class = "input-field" id = "UserGender" multiple = "no">
							<option value = "male" id = "male" selected>Male</option>
							<option value = "female" id = "female">Female</option>
						</cfselect>
					</td>
					<td><div class = "errorfield" id = "genderError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
					<td>Date of birth:</td>
						<td><input type = "date" name = "birthDate" class = "input-field" id = "birthDate"></td>
					<td><div class = "errorfield" id = "dateOfBirthError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Address</td>
						<td><cfinput type = "text" name = "address" class = "input-field" id = "address"></td>
						<td><div class = "errorfield" id = "addressError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Phone Number:</td>
						<td><cfinput type = "text" name = "phoneNumber" class = "input-field" id = "phoneNumber"></td>
						<td><div class = "errorfield" id = "phoneNumberError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Email Id:</td>
						<td><cfinput type = "text" name = "emailId" class = "input-field" id = "emailId"></td>
						<td><div class = "errorfield" id = "emailIdError"></div></td>
					</div>
				</tr>
				<tr>
		 			<div id = "field">
		 				<td>Password:</td>
		 				<td><cfinput type = "password" name = "password" class = "input-field" id = "password"></td>
						<td><div class = "errorfield" id = "passwordError"></div></td>
		 			</div>
		 		</tr>
		 		<tr>
		 			<div class = "field">
		 				<td>Confirm Password:</td>
		 				<td><cfinput type = "password" name = "confirmPassword" class = "input-field" id = "confirmPassword"></td>
		 				<td><div class = "errorfield" id = "confirmPasswordError"></div></td>
		 			</div>
		 		</tr>
				<tr>
					<td><cfinput type = "submit" name = "saveChanges" class = "form-submit-button" value = "Submit"></td>
				</tr>
			</table>
		</cfform>
		<a href = "../views/LoginPage.cfm">Click here to login</a>
	</div>

		<cfif isDefined("form.saveChanges") >
			<cfset formData = CreateObject("Component", "Model.RegistrationPageAction") >
			<cfset isValid = formData.validateRegistrationForm()>
			<cfif isValid EQ "true">
				<cfset formDataInserted = formData.insertDataRegistrationForm(argumentCollection="form")>
				<cfif formDataInserted EQ true>
					<cflocation url = "../views/LoginPageAction.cfm" addtoken = "false">
				<cfelse>
					<h5>Opps! Please check all the fields</h5>
			</cfif>
		<cfelse>
			<cfoutput>#isValid#</cfoutput>
		</cfif>
	</cfif>
	<script src = "../includes/js/validateRegistrationForm.js"></script>
</body>

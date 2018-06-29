<!--- File name: Login.cfm
	Description: It is the sign in page of the application
	Author: saura
--->
<!DOCTYPE html>
<head>
	<link rel = "stylesheet" href = "/coldboxapp/includes/css/login_page_style.css"/>
	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
</head>
<body>
	<div class = "formcontainer">
	<!--- Login form --->
		<h2>Sign In</h2>
		<cfform onsubmit = "return validateFormData()" action = "index.cfm/Common/LoginAction" method = "post" name="submit">
			<table>
				<tr>
					<div class = "field">
						<td>Email Id:</td>
						<td><cfinput type = "text" name = "emailId" class = "input-field" id = "emailId" placeholder = "Enter your email"></td>
						<td><div class = "errorfield" id = "emailIdError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Password:</td>
						<td><cfinput type = "password" name = "password" class = "input-field" id = "password" placeholder = "Enter your password"></td>
						<td><div class = "errorfield" id = "passwordError"></div></td>
					</div>
				</tr>
				<tr>
					<td><cfinput type = "submit" name = "submit" class = "form-submit-button" id = "submit" value = "Login"></td>
				</tr>
				<tr>
					<td><a href = "../coldboxapp/index.cfm/Common/ForgotPassword.cfm">Forgot Password</a></td>
				</tr>
			</table>
		</cfform>
		Not registered? Create an account <a href = "../coldboxapp/index.cfm/Common/Register.cfm">here</a>
	</div>
	<!-- Scripts -->
	<script src = "../../../coldboxapp/includes/js/validateLoginPage.js"></script>

</body>
</html>
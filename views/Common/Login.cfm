<!--- File name: Login.cfm 
	Description: It is the sign in page of the application
--->
<!DOCTYPE html>
<head>
	<link rel = "stylesheet" href = "/coldboxapp/includes/css/login_page_style.css"/>
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel = "stylesheet">
</head>
<body>
	<div class = "topnav">
        <a href = "../coldboxapp/index.cfm/Common/Register.cfm">Sign Up</a>
    </div>
	<div class = "formcontainer">
	<!--- Login form --->
		<h5><u>Login</u></h5>
		<cfform onsubmit = "return validateFormData()" action = "index.cfm/Common/LoginAction" method = "post" name="submit">
			<table>
				<tr>
					<div class = "field">
						<td>Email Id:</td>
						<td><cfinput type = "text" name = "emailId" class = "input-field" id = "emailId"></td>
						<td><div class = "errorfield" id = "emailIdError"></div></td>
					</div>
				</tr>
				<tr>
					<div class = "field">
						<td>Password:</td>
						<td><cfinput type = "password" name = "password" class = "input-field" id = "password"></td>
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
	</div>


	<!---  Link to Signup page --->
	<!--- <a href = "	../coldboxapp/index.cfm/Common/Register.cfm">Register Here</a> --->
	<script src = "../../../coldboxapp/includes/js/validateLoginPage.js"></script>

</body>
</html>
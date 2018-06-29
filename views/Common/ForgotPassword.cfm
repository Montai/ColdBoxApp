<!--- File name: ForgotPassword.cfm
    Description: View page for the forgot password form
	Author: saura
--->

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<link rel = "stylesheet" href = "/coldboxapp/includes/css/login_page_style.css"/>
<body>
	<div class = "formcontainer">
	<!--- Login form --->
		<h5><u>Forgot Password</u></h5>
		<cfform onsubmit = "return validateFormData()" action = "../../index.cfm/Common/ForgotPasswordAction" method = "post" name = "submit">
			<table>
				<tr>
					<div class = "field">
						<td>Enter your email Id:</td>
						<td><cfinput type = "text" name = "emailId" class = "input-field" id = "emailId"><br></td>
						<td><div class = "errorfield" id = "emailIdError"></div></td>
					</div>
				</tr>
				<tr>
					<td><br><cfinput type = "submit" name = "submit" class = "form-submit-button" id = "submit" value = "Submit"></td>
					<td><br><button onclick="location.href='../../index.cfm'" type = "button" class = "back-button">Back</button></td>
				</tr>
			</table>
		</cfform>
	</div>
</body>
<!-- Scripts -->
<script src = "../../../coldboxapp/includes/js/validateForgotPassword.js"></script>
</html>

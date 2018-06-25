<!--- File name: ForgotPassword.cfm 
    Description: View page for the forgot password form
--->

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
<link rel = "stylesheet" href = "/coldboxapp/includes/css/login_page_style.css"/>
<body>
	<div class = "formcontainer">
	<!--- Login form --->
		<h5><u>Forgot Password</u></h5>
		<cfform onsubmit = "" action = "../../index.cfm/Common/ForgotPasswordAction" method = "post" name = "submit">
			<table>
				<tr>
					<div class = "field">
						<td>Enter your email Id:</td>
						<td><cfinput type = "text" name = "emailId" class = "input-field" id = "emailId"></td>
						<td><div class = "errorfield" id = "emailIdError"></div></td>
					</div>
				</tr>
				<tr>
					<td><cfinput type = "submit" name = "submit" class = "form-submit-button" id = "submit" value = "Submit"></td>
				</tr>
			</table>
		</cfform>
	</div>
</body>
<script src = "../../../coldboxapp/includes/js/validateLoginPage.js"></script>
</html>

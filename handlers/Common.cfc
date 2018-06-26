/**
* File Name: Common.cfc
  Description: This is the basic handler component for handling all the basic actions
*/
component displayname = "Common" hint = "Common Controller for handling basic operations" extends = "coldbox.system.EventHandler" {
	property name = "LoginService" inject = "Login";
	property name = "RegisterService" inject = "Register";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};
	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/

	/**
	* Method Name: Login
	* Description: Sets the Login page view
	*/
	public void function Login(event, rc, prc) {	
		if(NOT StructIsEmpty(URL)) {
			local.errorMessages = "#URL.error#";
			writeOutput("<p>#errorMessages#</p>");
		}
		event.setView( "Common/Login" ).noLayout();
	}

	/**
	* Method Name: Login Action
	* Description: Performs and handles the action after submitting the login form
	*/
	public void function LoginAction(event, rc, prc) {
		if(isDefined("form.submit")) {
			//local.myModel = getModel("Common.LoginPageAction");
			local.myModel = getInstance("Common.LoginPageAction");
			//writeDump(myModel.validateLoginForm()); 
			//writeDump(LoginService.validateLoginForm);
			//abort;
			//local.myModel = LoginAction.checkFormData();
			local.validationStatus = LoginService.validateLoginForm();
			//writedump("#local.validationStatus#"); abort;
			//writeDump(validationStatus); abort;
			if(validationStatus[1] EQ "true") {
				event.setView("Common/Home").noLayout();
			} else { 
				local.validationErr = "";
				ArrayEach(local.validationStatus, function(error){
       		      	validationErr = validationErr & error & '<br>';
            	});
				location("../../index.cfm?error=#validationErr#", false, 301);
			}
		} else {
			event.setView("Common/Register").noLayout();
		}
	}

	/**
	* Method Name: Register
	* Description: Sets the Register page view
	*/
	public void function Register(event, rc, prc) {
		if(NOT StructIsEmpty(URL)) {
			local.errorMessages = "#URL.error#";
			writeOutput("<h4>The following errors restricts the user:</h4>
			<p>#errorMessages#</p>");
		}
		event.setView("Common/Register").noLayout();
	}

	/**
	* Method name: Register Action
	* Description: Performs and handles the action after submitting the registration form
	**/

	public void function RegisterAction(event, rc, prc) {
		if(isDefined("form.saveChanges")) {
			local.formData = getInstance("Common.RegistrationPageAction");
			local.isValid = RegisterService.validateRegistrationForm();
			if(arrayIsEmpty(isValid)) {
				local.formDataInserted = RegisterService.insertDataRegistrationForm(argumentCollection="form");
				if(local.formDataInserted EQ true) {
					location("../..");
				} else {
					location("../Common/Register");
				}
			} else {
				local.validationErr = "";
				ArrayEach(local.isValid, function(error) {
       		      	validationErr = validationErr & error & '<br>';
            	});
				location("../../index.cfm/Common/Register?error=#validationErr#",false,301);
			}
		} else {
			local.message = "Error in submitting form";
			OnError(event, rc, prc, message);
		}
	}

	/**
	* Method Name: ForgotPassword
	* Description: Sets the forgot password view
	*/
	public void function ForgotPassword(event, rc, prc) {
		if(NOT StructIsEmpty(URL)) {
			local.errorMessages = "#URL.message#";
			writeOutput("<p>#errorMessages#</p>");
		}
		event.setView( "Common/ForgotPassword" ).noLayout();
	}

	/**
	* Method Name: ForgotPasswordAction
	* Description: Send mail and handles the action after submitting the ForgotPassword form
	**/

	public void function ForgotPasswordAction(event, rc, prc) {
		if(isDefined("form.submit")) {
			local.formData = getModel("Common.ForgotPasswordPageAction");
			local.sendMail = formData.sendEmailToUser();
			if(sendMail EQ "true") {
				location("../../index.cfm?error=#"Email sent"#",false,301);
			}
			else if(sendMail EQ "false") {
			 	local.message = "Unable to send mail";
			 	OnError(event, rc, prc, message);
			}
			else {
				error = sendMail;
				location("../../index.cfm/Common/ForgotPassword?message=#error#",false,301);
			}
		} else {
			local.message = "Error in submitting form";
			OnError(event, rc, prc, message);
		}
	}

	/**
	* Method Name: Home
	* Description:  It shows the home page of the application
	*/
	public void function Home(event, rc, prc) {
		event.setView("Common/Home").noLayout();
	}

	/**
	* Method Name: About
	* Description: It shows the about page of the application
	*/
	public void function About(event, rc, prc) {
		event.setView( "Common/About" ).noLayout();
	}

	/**
	* Method Name: Logout
	* Description: It does the session handling 
	*/
	public void function Logout(event, rc, prc) {
		event.setView( "Common/LogOut" ).noLayout();
	}

	/**
	* Method name: OnError
	* Description: Displays the exception thrown by the applicaition
	*/
	public void function OnError(event, rc, prc, message) {
		log.warn("#message#");
		event.paramValue("error", message);
		event.setView("Common/OnError").noLayout();
	}
}
/**
* File Name: Common.cfc
  Description: This is the basic handler component for handling all the basic actions
*/
component displayname = "Common" hint = "Common Controller for handling basic operations" extends = "coldbox.system.EventHandler" {
	//property name = "Login" inject;
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
	* Login
	*/
	public void function Login( event, rc, prc ) {
		if(NOT StructIsEmpty(URL)) {
			local.errorMessages = "#URL.error#";
			writeOutput(errorMessages);
		}
		event.setView( "Common/Login" ).noLayout();
	}

	/**
	* Login Action
	*/
	public void function LoginAction( event, rc, prc ) {
		if(isDefined("form.submit")) {
			local.myModel = getModel("Common.LoginPageAction");
			local.validationStatus = myModel.validateLoginForm();
			if(validationStatus[1] EQ "true"){
				event.setView("Common/Home").noLayout();
			} else { 
				local.validationErr = "";
				ArrayEach(local.validationStatus, function(error){
       		      	validationErr = validationErr & error & '<br>';
            	});
				location("../../index.cfm?error=#validationErr#", true, 301);
			}
		} else {
			event.setView("Common/Register").noLayout();
		}
	}

	/**
	* Register
	*/
	public void function Register( event, rc, prc ){
		if(NOT StructIsEmpty(URL)) {
			local.errorMessages = "#URL.error#";
			writeOutput(errorMessages);
		}
		event.setView( "Common/Register" ).noLayout();
	}

	public void function RegisterAction(event, rc, prc) {
		if(isDefined("form.saveChanges")) {
			local.formData = getModel("Common.RegistrationPageAction");
			local.isValid = formData.validateRegistrationForm();
			if(arrayIsEmpty(isValid)) {
				local.formDataInserted = formData.insertDataRegistrationForm(argumentCollection="form");
				if(local.formDataInserted EQ true) {
					location("../Common/Login");
				} else {
					location("../Common/Register");
				}
			} else {
				local.validationErr = "";
				ArrayEach(local.isValid, function(error){
       		      	validationErr = validationErr & error & '<br>';
            	});
				location("../../index.cfm/Common/Register?error=#validationErr#",true,301);
			}
		} else {
			local.message = "Error in submitting form";
			OnError(event, rc, prc, message);
		}
	}

	/**
	* ForgotPassword
	*/
	public void function ForgotPassword( event, rc, prc ) {
		if(NOT StructIsEmpty(URL)) {
			local.errorMessages = "#URL.message#";
			writeOutput(errorMessages);
		}
		event.setView( "Common/ForgotPassword" ).noLayout();
	}

	public void function ForgotPasswordAction(event, rc, prc) {
		if(isDefined("form.submit")){
			local.formData = getModel("Common.ForgotPasswordPageAction");
			local.sendMail = formData.sendEmailToUser();
			if(sendMail EQ "true") {
				location("../../index.cfm?error=#"Email sent"#",true,301);
			}
			else if(sendMail EQ "false") {
			 	local.message = "Unable to send mail";
			 	OnError(event, rc, prc, message);
			}
			else {
				error = sendMail;
				location("../../index.cfm/Common/ForgotPassword?message=#error#",true,301);
			}
		} else {
			local.message = "Error in submitting form";
			OnError(event, rc, prc, message);
		}
	}

	/**
	* Home
	*/
	public void function Home( event, rc, prc ) {
		event.setView( "Common/Home" ).noLayout();
	}

	/**
	* About
	*/
	public void function About( event, rc, prc ) {
		event.setView( "Common/About" ).noLayout();
	}

	/**
	* Logout
	*/
	public void function Logout( event, rc, prc ) {
		event.setView( "Common/LogOut" ).noLayout();
	}

	/**
	* On Error method
	*/
	public void function OnError(event, rc, prc, message) {
		log.warn("#message#");
		event.paramValue("error", message);
		event.setView("Common/OnError").noLayout();
	}
}


/**
* File Name: Common.cfc
  Description: This is the basic handler component for handling all the basic actions
*/
component displayname = "Common"
			  hint = "Common Controller for handling basic operations"
			  extends = "coldbox.system.EventHandler" {

		property name = "LoginService" inject = "Login";
		property name = "RegisterService" inject = "Register";
		property name = "ForgotPasswordService" inject = "ForgotPassword";

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
		function preHandler(event, rc, prc, action, eventArguments){
		}
		function postHandler( event, rc, prc, action, eventArguments ){
		}
		function aroundHandler( event, rc, prc, targetAction, eventArguments ){
			// executed targeted action
			arguments.targetAction( event );
		} */
		function onMissingAction( event, rc, prc, missingAction, eventArguments ){
		}
		function onError(event, rc, prc, faultAction, exception, eventArguments) {
		}
		function onInvalidHTTPMethod(event, rc, prc, faultAction, eventArguments) {
			//Log locally
			log.warn("InvalidHTTPMethod Execution of (#arguments.faultAction#): #event.getHTTPMethod()#", getHTTPRequestData());
	    	// Setup Response
		    prc.response = getInstance("Response")
	        			   .setError(true)
	        			   .setErrorCode(405)
	        			   .addMessage("InvalidHTTPMethod Execution of (#arguments.faultAction#): #event.getHTTPMethod()#")
	        			   .setStatusCode(405)
	        			   .setStatusText("Invalid HTTP Method");
	    	// Render Error Out
		    event.renderData(
		        type = prc.response.getFormat(),
		        data = prc.response.getDataPacket(),
		        contentType = prc.response.getContentType(),
		        statusCode = prc.response.getStatusCode(),
		        statusText = prc.response.getStatusText(),
		        location = prc.response.getLocation(),
		        isBinary = prc.response.getBinary()
	    	);
		}
		function missingTemplate(event, rc, prc) {
			//log a warning
			log.warn("Missing page detected: #rc.missingTemplate#");
	    	event.renderData(data="<h1>Page Not Found</h1>", statusCode=404);
	    	// Set a page for rendering and a 404 header
	    	event.setView("main/pageNotFound").setHTTPHeader("404", "Page Not Found");
		}

		private void function pageNotFound(event, rc, prc) {
			log.warn("Invalid page detected: #prc.invalidEvent#");
			event.renderData(data="<h1>Page Not Found, Please enter a valid URL</h1>", statusCode = 404);
			//Set a page for rendering and a 404 header
			event.setView("main/pageNotFound").setHTTPHeader("404", "Page Not Found");
		}

		/**
		* Method Name: Login
		* Description: Sets the Login page view
		*/
		public void function Login(event, rc, prc) {
			if(StructKeyExists(URL,"error") EQ "YES") {
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
				local.validationStatus = LoginService.validateLoginForm();
				if(validationStatus[1] EQ "true") {
					//Rotate the session after successful login
					sessionRotate();
					location("Home.cfm?rotate=TRUE");
				} else {
					local.validationErr = "";
					ArrayEach(local.validationStatus, function(error) {
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
			if(StructKeyExists(URL,"error") EQ "YES") {
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
					location("../../index.cfm/Common/Register?error=#validationErr#", false, 301);
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
			if(StructKeyExists(URL,"message") EQ "YES") {
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
				//local.formData = getModel("Common.ForgotPasswordPageAction");
				local.sendMail = ForgotPasswordService.sendEmailToUser();
				if(sendMail EQ "true") {
					location("../../index.cfm?error=#"Email sent"#",false,301);
				}
				else if(sendMail EQ "Unable to send mail") {
				 	local.message = sendMail;
				 	OnError(event, rc, prc, message);
				}
				else {
					error = sendMail;
					location("../../index.cfm/Common/ForgotPassword?message=#error#", false, 301);
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
			sessionInvalidate();
			event.setView( "Common/LogOut" ).noLayout();
		}

		public void function onException(event, rc, prc) {
			//log the error via LogBox
			log.error(prc.exception.getMessage() & prc.exception.getDetail(), prc.exception.getMemento());
			//flash where the exception occured
			flash.put("exceptionURL", event.getCurrentRoutedURL());
			//Relocate to fail page
			setNextEvent("index.cfm/common/OnError");
		}
}
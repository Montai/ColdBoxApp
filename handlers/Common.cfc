/**
* I am a new handler
*/
component name="Common" hint="" extends="coldbox.system.EventHandler"{
	property name = "loginService" inject = "Login";
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
	public void function Login( event, rc, prc ){
		event.setView( "Common/Login" ).noLayout();
	}

	/**
	* loginaction
	*/
	public void function LoginAction( event, rc, prc ){
		// writedump(form); 
		// writedump(Login);
		// abort;
		if(isDefined("form.submit")) {
			myModel = getModel("Common.LoginPageAction");
			writedump(myModel);
			abort;
			local.validationStatus = myModel.ValidateLoginForm(form.emailId, form.password);
			if(local.validationStatus EQ true) {
				local.userFormData = myModel.CheckFormData(form.emailId, form.password);
				if(local.userFormData EQ true) {
					location("/Home", "false", "301");
				} else {
					//writeOutput("Opps! Email or Password is incorrect, Please provide the correct details");
				}
			}
		} else {

		}
	}

	/**
	* Register
	*/
	public void function Register( event, rc, prc ){
		event.setView( "Common/Register" ).noLayout();
	}

	/**
	* ForgotPassword
	*/
	public void function ForgotPassword( event, rc, prc ){
		event.setView( "Common/ForgotPassword" ).noLayout();
	}

	/**
	* Home
	*/
	public void function Home( event, rc, prc ){
		event.setView( "Common/Home" ).noLayout();
	}

	/**
	* About
	*/
	public void function About( event, rc, prc ){
		event.setView( "Common/About" ).noLayout();
	}

	/**
	* Logout
	*/
	public void function Logout( event, rc, prc ){
		event.setView( "Common/LogOut" ).noLayout();
	}
}


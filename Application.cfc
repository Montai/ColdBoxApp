/**
File name: Application.cfc
Component name: Application level component
Description: This file handles the Lifecycle events of the entire flow of the application
* Author: saura
* ---
*/
component displayname = "Application level component" hint = "Does all the application level settings" {
	// Application properties
	this.name = "hash( getCurrentTemplatePath() )";
	this.sessionManagement = true;
	this.applicationTimeout = createTimeSpan(0,0,30,0);
	this.sessionTimeout = createTimeSpan(0,0,25,0);
	this.setClientCookies = true;
	this.datasource = "cfartgallery";
	this.mappings[ '/coldbox' ] = 'D:\MyCodings\Coding1\ColdBoxApp\coldbox\';

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";

	// application start
	public boolean function onApplicationStart(){
		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();
		return true;
	}

	// application end
	public void function onApplicationEnd(struct appScope){
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	// request start
	public boolean function onRequestStart(string targetPage){
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart(arguments.targetPage);
		if(CGI.HTTP_URL EQ "/coldboxapp/index.cfm/Common/home" OR CGI.HTTP_URL EQ "/coldboxapp/index.cfm/Common/about" OR CGI.HTTP_URL EQ "/coldboxapp/index.cfm/Common/logout"
		OR CGI.HTTP_URL EQ "/coldboxapp/index.cfm/Common/OnError") {
			if(structKeyExists(session, "user")) {
				location("/coldboxapp/index.cfm/Common/home");
			}
			else {
				location("/coldboxapp/index.cfm");
			}
		}
		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd(struct sessionScope, struct appScope){
		arguments.appScope.cbBootStrap.onSessionEnd(argumentCollection=arguments);
	}

	public boolean function onMissingTemplate(template) {
		return application.cbBootstrap.onMissingTemplate(argumentCollection=arguments);
	}

	function onError(any Exception, string EventName) {
		var errorMessages = "<h2>An unexpected error occured. Error details:</h2>
							Message: #arguments.exception.message#</br>
							Root Cause Message: #arguments.exception.rootcause.message#</br>
							Details: #arguments.exception.message#</br>
							Message: #arguments.exception.detail#";
		//writelog(errorMessages,"Application",ErrorReport.txt,"error",true);
		writelog("Message: #arguments.exception.message#");
		//writeLog("Root Cause Message: #arguments.exception.rootcause.message#");
		//writeLog("Details: #arguments.exception.type#");
		//writeLog("Message: #arguments.exception.detail#");
		//writeOutput("<h2>An unexpected error occurred.</h2>
		//			<p>Please provide the following information to technical support:</p>
		//			<p>Error Event: #Arguments.EventName#</p>
		//			<p>Error details:<br>");
		//writeDump(Arguments.Exception);
	}

}
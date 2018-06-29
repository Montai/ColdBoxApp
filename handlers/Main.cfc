component displayname = "main event handling handler"
		  hint = "Handles the implicit actions"
		  extends = "coldbox.system.EventHandler" {

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){

	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc) {
		//log the exception via logbox
		log.error(prc.exception.getMessage() & prc.exception.getDetail(), prc.exception.getMemento());
		//flash where the exception occured
		flash.put("exceptionURL", event.getCurrentRoutedURL());
		//Relocate to fail page
		setNextElement("main.fail");
	}

	private void function pageNotFound(event, rc, prc) {
		log.warn("Invalid page detected: #prc.invalidEvent#");
		event.renderData(data="<h1>Page Not Found</h1>", statusCode = 404);
		//Set a page for rendering and a 404 header
		event.setView("main/pageNotFound").setHTTPHeader("404", "Page Not Found");
	}

	function missingTemplate(event, rc, prc) {
		//log a warning
		log.warn("Missing page detected: #rc.missingTemplate#");
    	event.renderData(data="<h1>Page Not Found</h1>", statusCode=404);
    	// Set a page for rendering and a 404 header
    	event.setView("main/pageNotFound").setHTTPHeader("404", "Page Not Found");
	}

	function onMissingTemplate(event,rc,prc) {
		//Grab missingTemplate From request collection, placed by ColdBox
		var missingTemplate = event.getValue("missingTemplate");

	}

}
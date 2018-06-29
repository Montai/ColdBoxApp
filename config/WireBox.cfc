/*
File name: WireBox.cfc
Description: This is the configuration file for the wirebox
* Author: saura
*/
component displayname = "Wirebox config"
		  hint = "Config settings for wirebox"
		  extends = "coldbox.system.ioc.config.Binder" {

	/**
	* Configure WireBox, that's it!
	*/
	function configure(){

		// The WireBox configuration structure DSL
		wireBox = {
			// Scope registration, automatically register a wirebox injector instance on any CF scope
			// By default it registeres itself on application scope
			scopeRegistration = {
				enabled = true,
				scope   = "application", // server, cluster, session, application
				key		= "wireBox"
			},

			// DSL Namespace registrations
			customDSL = {
				// namespace = "mapping name"
			},

			// Custom Storage Scopes
			customScopes = {
				// annotationName = "mapping name"
			},

			// Package scan locations
			scanLocations = ["models"],

			// Stop Recursions
			stopRecursions = [],

			// Parent Injector to assign to the configured injector, this must be an object reference
			parentInjector = "",

			// Register all event listeners here, they are created in the specified order
			listeners = [
				// { class="", name="", properties={} }
			]
		};

		// Map Bindings below
		map("Login").to("models.Common.LoginPageAction");
		map("Register").to("models.Common.RegistrationPageAction");
		map("ForgotPassword").to("models.Common.ForgotPasswordPageAction");
		//mapDirectory("models.Common");
	}

}
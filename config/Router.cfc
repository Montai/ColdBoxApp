component{

	function configure(){
		setFullRewrites( true );

		route( ":handler/:action?" ).end();
		route( "/coldboxapp/index.cfm" ).toView("/index");
		route("/coldboxapp/Common/Home").toView("/home");
		route("/coldboxapp/Common/About").toView("/about");		
		route("/coldboxapp/Common/Logout").toView("/logout");
	}

}
component{

	function configure(){
		setFullRewrites( true );

		route( ":handler/:action?" ).end();
		//route("/index").toView("views/Common/Login.cfm");
	}

}
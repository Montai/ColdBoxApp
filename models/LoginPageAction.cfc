/**
* I am a new Model Object
*/
component accessors="true"{
	
	// Properties
	

	/**
	 * Constructor
	 */
	LoginPageAction function init(){
		
		return this;
	}
	function ValidateLoginForm(email, password) {
		variables.flag = true;
		if(not isValid("email", arguments.email)) 
			variables.flag = false;
		if(if len(arguments.password) GTE 6 AND len(arguments.password) LTE 20)
			variables.flag = false;
		return variables.flag;
	}
	function CheckFormData(email, password) {
		try {
			variables.myQueryResult = new Query();
			variables.myQueryResult.setDatasource("cfartgallery");
			variables.myQueryResult.setSQL("SELECT PASSWORD, SALT
								FROM Users
								WHERE EMAILID = :currentUserEmail");
			variables.myQueryResult.addParam(name: "currentUserEmail", value: "#arguments.email#", cfsqltype: "CF_SQL_VARCHAR");
			variables.getQueryResult = variables.myQueryResult.execute();
			if(variables.getQueryResult.RecordCount EQ 1) {
				if(request.getQueryResult.PASSWORD EQ Hash(arguments.password & variables.getQueryResult.SALT, "SHA-512"))
					return true;
				else 
					return false;
			}
		} catch(any) {
			writeOutput("DataBase Exception occured");
			return false;
		}
	}
	
}
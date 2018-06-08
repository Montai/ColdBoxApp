/**
* I am a new Model Object
*/
component accessors="true"{
	
	// Properties
	

	/**
	 * Constructor
	 */
	RegistrationPageAction function init(){
		return this;
	}
	function validateRegistrationForm() {
		variables.errorArray = new Array(1);
		variables.getEmailQuery = new Query();
		variables.getEmailQuery.setDatasource("cfartgallery");
		variables.getEmailQuery.setSQL("SELECT EMAILID
										FROM Users
										WHERE EMAILID = :currentEmail");
		variables.getEmailQuery.addParam(name: "currentEmail", value: "#form.emailId#", cfsqltype: "CF_SQL_VARCHAR");
		variables.getResultQuery = getEmailQuery.execute();
		if(not isValid("regex", form.firstName, "^[a-zA-Z]*$") or form.firstName EQ "") {
			arrayAppend(errorArray, "Invalid First Name");
		} 
		if(form.MiddleName NEQ "" and not isValid("regex", form.middleName, "^[a-zA-Z]*$")) {
			arrayAppend(errorArray, "Invalid Middle Name");
		}
		if(not isValid("regex", form.lastName, "^[a-zA-Z]*$") or form.lastName EQ "") {
			arrayAppend(errorArray, "Invalid Last Name");
		}
		if(not (form.userGender EQ "male" or form.userGender EQ "female")) {
			arrayAppend(errorArray, "Invalid Gender");
		}
		if(not isValid("date", form.birthDate) or form.birthDate EQ "") {
			arrayAppend(errorArray, "Invalid Date of Birth");
		}
		if(not(len(form.address) GTE 10 AND len(form.address) LTE 100)) {
			arrayAppend(errorArray, "Invalid Address");
		}
		if(not(len(form.phoneNumber) EQ 10)) {
			arrayAppend(errorArray, "Invalid Phone Number, Please check the phone number format");
		}
		if(not isValid("email", form.emailId)) {
			arrayAppend(errorArray, "Email Id is blank");
		}
		if(not "#getEmail.EMAILID#" EQ "") {
			arrayAppend(errorArray, "Email Already Exists");
		}
		if(not(len(form.password) GTE 6 AND len(form.password) LTE 20) or form.password EQ "") {
			arrayAppend(errorArray, "Invalid Password");
		}
		if(not(len(form.confirmPassword) GTE 6 AND len(form.confirmPassword) LTE 20) or form.confirmPassword EQ "") {
			arrayAppend(errorArray, "Invalid Confirm Password");
		}
		return errorArray;
	}

	function insertDataRegistrationForm() {
		variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512");
		variables.hashedPassword = Hash(form.password & variables.salt, "SHA-512");
		variables.insertDataQuery = new Query();
		variables.insertDataQuery.setDatasource("cfartgallery");
		try {
			variables.insertDataQuery.setSQL("INSERT INTO Users(FIRSTNAME, MIDDLENAME, LASTNAME, GENDER, DATEOFBIRTH, ADDRESS, PHONENUMBER, EMAILID, PASSWORD, CONFIRMPASSWORD, SALT)
										  VALUES ('#form.firstName#','#form.middleName#', '#form.lastName#', '#form.userGender#', 
										  '#form.birthDate#', '#form.address#', '#form.phoneNumber#','#form.emailId#',
										  '#variables.hashedPassword#', '#variables.hashedPassword#', '#variables.salt#')");
		} catch(any) {
			//writeOutput("Sorry, Unable to insert");
			return false;
		}
		return true;
	}

}
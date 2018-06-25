/** File Name: validateLoginPage.js
 *  Description: Does the client side validation for the login form
**/
function validForm() {
    this.defaultName = "Validate Login Form";
    this.emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[a-zA-Z]{2,4}$/;
    this.passwordRegex = /^[a-zA-Z0-9!@#$%^&*]{6,20}$/;
    this.email = "";
    this.password = "";
}
validForm.prototype.setEmail = function() {
    this.email = document.getElementById("emailId").value;  
    //console.log(this.email);
};
validForm.prototype.setPassword = function() {
    this.password = document.getElementById("password").value; 
};

validForm.prototype.getEmail = function() { return this.email; }
validForm.prototype.getPassword = function() { return this.password; }
validForm.prototype.isBlank = function(testString) {
    if(testString === "") 
        return true;
    else
        return false;
}

validForm.prototype.getEmailAndPassword = function() {
    return this.email + " " + this.password;
}

validForm.prototype.setDataError = function(error, elementId) {
    document.getElementById(elementId).innerHTML = error;
}
validForm.prototype.isValid = function() { 
    this.setEmail();
    this.setPassword();
    var userEmail = this.getEmail();
    var userPassword = this.getPassword();
    var flag = true;
    var error = "";
    var elementId = "";
    
    if(this.isBlank(userEmail)) { 
        error = "Email cannot be blank";
        elementId = "emailIdError";
        this.setDataError(error, elementId);
        flag = false;
        return flag;
    } 
    else {
        document.getElementById("emailIdError").innerHTML = "";
    }
    if(this.emailRegex.test(userEmail) == false) {
        error = "Check proper e-mail format, Proper email format is:(abc@domain.com)";
        elementId = "emailIdError";
        this.setDataError(error, elementId);
        flag = false;
        return flag;
    }
    if(this.isBlank(this.getPassword())) {
         error = "Password cannot be blank";
         elementId = "passwordError";
         this.setDataError(error, elementId);
         flag = false;
         return flag;
    } else {
         document.getElementById("passwordError").innerHTML = "";
    }
    if(this.passwordRegex.test(userPassword) == false) {
         error = "Password should contain either combination of alphabets, or digits or special characters. It should be at least 6 and at max 20 characters";
         elementId = "passwordError";
         this.setDataError(error, elementId);
         flag = false;
         return flag;
    }
    return flag;
};
function validateFormData() {
    var form = new validForm();
    return form.isValid();
}

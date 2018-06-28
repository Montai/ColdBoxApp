/** File Name: validateLoginPage.js
 *  Description: Does the client side validation for the login form
**/
function validForm() {
    this.defaultName = "Validate Forgot Password Form";
    this.emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[a-zA-Z]{2,4}$/;
    this.email = "";
}
validForm.prototype.setEmail = function() {
    this.email = document.getElementById("emailId").value;  
};

validForm.prototype.getEmail = function() { return this.email; }
validForm.prototype.isBlank = function(testString) {
    if(testString === "") 
        return true;
    else
        return false;
}

validForm.prototype.setDataError = function(error, elementId) {
    document.getElementById(elementId).innerHTML = error;
}
validForm.prototype.isValid = function() { 
    this.setEmail();
    var userEmail = this.getEmail();
    var flag = true;
    var error = "";
    var elementId = "";
    
    if(this.isBlank(userEmail)) { 
        error = "Email cannot be blank";
        elementId = "emailIdError";
        this.setDataError(error, elementId);
        flag = false;
    } 
    else {
        if(this.emailRegex.test(userEmail) == false) {
            error = "Check proper e-mail format, Proper email format is:(abc@domain.com)";
            elementId = "emailIdError";
            this.setDataError(error, elementId);
            flag = false;
            //return flag;
        }
        else {
            document.getElementById("emailIdError").innerHTML = "";
        }
    }
    return flag;
};
function validateFormData() {
    var form = new validForm();
    return form.isValid();
}
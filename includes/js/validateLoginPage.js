function validateFormData() {
    var emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[a-zA-Z]{2,4}$/;
    var passwordRegex = /^[a-zA-Z0-9!@#$%^&*]{6,20}$/;

    var email = document.getElementById("emailId").value;
    var password = document.getElementById("password").value;

    if(email == "") {
        document.getElementById("emailIdError").innerHTML = "Email can't be blank";
        return false;
    } else {
        document.getElementById("emailIdError").innerHTML = "";
    }
    if(emailRegex.test(email) == false) {
        document.getElementById("emailIdError").innerHTML = "Please enter a valid email id";
        return false;
    }
    if(password == "") {
        document.getElementById("passwordError").innerHTML = "Password can't be blank";
        return false;
    }
    else {
        document.getElementById("passwordError").innerHTML = "";
    }
    if(passwordRegex.test(password) == false) {
        document.getElementById("passwordError").innerHTML = "Enter correct combination of alphabets, numbers or special char";
        return false;
    }
    return true;
}
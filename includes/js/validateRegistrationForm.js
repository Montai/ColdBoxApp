function validateForm() {
    var fname = document.getElementById("firstName").value;
    var mname = document.getElementById("middleName").value;
    var lname = document.getElementById("lastName").value;
    var gender = document.getElementById("UserGender").options[document.getElementById("UserGender").options.selectedIndex].value;
    var dateOfBirth = document.getElementById("birthDate").value;
    var address = document.getElementById("address").value;
    var phoneNumber = document.getElementById("phoneNumber").value;
    var email = document.getElementById("emailId").value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    var nameRegex = /^([a-zA-Z]{2,20})$/;
    var emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[a-zA-Z]{2,4}$/;
    var phoneRegex = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/;
    var passwordRegex = /^[a-zA-Z0-9!@#$%^&*]{6,20}$/;
    
    if(fname == "") {
        document.getElementById("firstNameError").innerHTML = "First Name is blank";
        return false;
    } else {
        document.getElementById("firstNameError").innerHTML = "";
    }
    if(nameRegex.test(fname) == false) {
        document.getElementById("firstNameError").innerHTML = "First Name can contain only alphabets";
        return false;
    }
    if(mname != "" && nameRegex.test(mname) == false) {
        document.getElementById("middleNameError").innerHTML = " Middle Name can contain only alphabets";
        return false;
    }
    else {
        document.getElementById("middleNameError").innerHTML = "";
    }
    if(lname == "") {
        document.getElementById("lastNameError").innerHTML = "Last Name is blank";
        return false;
    }
    else {
        document.getElementById("lastNameError").innerHTML = "";
    }
    if(nameRegex.test(lname) == false) {
        document.getElementById("lastNameError").innerHTML = "Last Name can contain only alphabets";
        return false;
    }
    if(gender != "male" && gender != "female") {
        document.getElementById("genderError").innerHTML = "Gender can be male or female only";
        return false;
    }
    if(dateOfBirth == "") { document.getElementById("dateOfBirthError").innerHTML = "Date can't be blank"; return false; }
    else {
        document.getElementById("dateOfBirthError").innerHTML = "";
    }
    if(dateOfBirth != "") {
        var today = new Date();
        var mydate = new Date(dateOfBirth);
        if(mydate >= today) { 
            document.getElementById("dateOfBirthError").innerHTML = "Date can't be in future"; 
            return false;
        }
    }
    if(address == "") {
        document.getElementById("addressError").innerHTML = "Address can't be blank";
        return false;
    }else {
        document.getElementById("addressError").innerHTML = "";
    }
    if(phoneNumber == "") {
        document.getElementById("phoneNumberError").innerHTML = "Phone Number can't be blank";
        return false;
    }else {
        document.getElementById("phoneNumberError").innerHTML = "";
    }
    if(phoneRegex.test(phoneNumber) == false) {
        document.getElementById("phoneNumberError").innerHTML = "Invalid Phone Number format";
        return false;
    }
    if(email == "") {
        document.getElementById("emailIdError").innerHTML = "Email can't be blank";
        return false;
    }else {
        document.getElementById("emailIdError").innerHTML = "";
    }
    if(emailRegex.test(email) == false) {
        document.getElementById("emailIdError").innerHTML = "Provide a valid email";
        return false;
    }
    if(password == "") {
        document.getElementById("passwordError").innerHTML = "Password can't be blank";
        return false;
    }else {
        document.getElementById("passwordError").innerHTML = "";
    }
    if(passwordRegex.test(password) == false) {
        document.getElementById("passwordError").innerHTML = "Password contains only letters, numbers and special characters";
        return false;
    }
    if(confirmPassword == "") {
        document.getElementById("confirmPasswordError").innerHTML = "Can't be blank";
        return false;
    }else {
        document.getElementById("confirmPasswordError").innerHTML = "";
    }
    if(password != confirmPassword) {
        document.getElementById("confirmPasswordError").innerHTML = "Passwords didn't match";
        return false;
    }
    return true;
}
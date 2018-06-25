/** File Name: validateRegistrationForm.js
 * Description: Does the client side validation of the Registration Form 
 * 
**/
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

    var flag = true;
    
    if(fname == "") {
        document.getElementById("firstNameError").innerHTML = "First Name is blank";
        flag = false;
    } 
    else {
        if(nameRegex.test(fname) == false) {
            document.getElementById("firstNameError").innerHTML = "First Name can contain only alphabets, and it should be at least 2 and at max 20 chars";
            flag = false;
        }
        else {   
            document.getElementById("firstNameError").innerHTML = "";
        }
    }
    
    
    if(mname != "" && nameRegex.test(mname) == false) {
        document.getElementById("middleNameError").innerHTML = " Middle Name can contain only alphabets, and it should be at least 2 and at max 20 chars";
        flag = false;
    }
    else {
        document.getElementById("middleNameError").innerHTML = "";
    }

    if(lname == "") {
        document.getElementById("lastNameError").innerHTML = "Last Name is blank";
        flag = false;
    }
    else {
        if(nameRegex.test(lname) == false) {
            document.getElementById("lastNameError").innerHTML = "Last Name can contain only alphabets, and it should be at least 2 and at max 20 chars";
            flag = false;
        }
        else {
            document.getElementById("lastNameError").innerHTML = "";
        }
    }
    
    
    if(gender != "male" && gender != "female") {
        document.getElementById("genderError").innerHTML = "Gender can be male or female only";
        flag = false;
    }
    if(dateOfBirth == "") { 
        document.getElementById("dateOfBirthError").innerHTML = "Date can't be blank"; 
        flag = false;
    }
    else {
        if(dateOfBirth != "") {
            var today = new Date();
            var mydate = new Date(dateOfBirth);
            if(mydate >= today) { 
                document.getElementById("dateOfBirthError").innerHTML = "Date of birth can't be in future"; 
                flag = false;
            }
        }
        else {
            document.getElementById("dateOfBirthError").innerHTML = "";
        }
    }
    
    
    if(address == "") {
        document.getElementById("addressError").innerHTML = "Address can't be blank";
        flag = false;
    }
    else {
        if(address.length <=10 && address.length >= 100) {
            document.getElementById("addressError").innerHTML = "Address should be at least contain 10 to 100 chars"
            flag = false;
        }
        else {
            document.getElementById("addressError").innerHTML = "";
        }
    }
    
    if(phoneNumber == "") {
        document.getElementById("phoneNumberError").innerHTML = "Phone Number can't be blank";
        flag = false;
    }
    else {
        if(phoneRegex.test(phoneNumber) == false) {
            document.getElementById("phoneNumberError").innerHTML = "Invalid Phone Number format, phone number should contain 10 digits";
            flag = false;
        }
        else {
            document.getElementById("phoneNumberError").innerHTML = "";
        }
    }
    
    
    if(email == "") {
        document.getElementById("emailIdError").innerHTML = "Email can't be blank";
        flag = false;
    }
    else {
        if(emailRegex.test(email) == false) {
            document.getElementById("emailIdError").innerHTML = "Provide a valid email, email is of format (abc@domain.com)";
            flag = false;
        }
        else {
            document.getElementById("emailIdError").innerHTML = "";
        }
    }
    
    if(password == "") {
        document.getElementById("passwordError").innerHTML = "Password can't be blank";
        flag = false;
    }
    else {
        if(passwordRegex.test(password) == false) {
            document.getElementById("passwordError").innerHTML = "Password contains only letters, numbers and special characters";
            flag = false;
        }
        else {
            document.getElementById("passwordError").innerHTML = "";
        }
    }
    
    
    if(confirmPassword == "") {
        document.getElementById("confirmPasswordError").innerHTML = "Can't be blank";
        flag = false;
    }
    else {
        if(password != confirmPassword) {
            document.getElementById("confirmPasswordError").innerHTML = "Passwords didn't match";
            flag = false;
        }
        else {
            document.getElementById("confirmPasswordError").innerHTML = "";
        }
    }
    
    return flag;
}
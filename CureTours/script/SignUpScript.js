var username, password, name, phone, email;
var userREGEX = /^[a-z0-9A-Z_]{5,20}$/;
var passREGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
var nameREGEX = /^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/;
var phoneREGEX = /^((\+92)|(0092)|(92))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$/;
var emailREGEX = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

function Validation() {
    if (!empty_validation() || !userREGEX.test(username) || !passREGEX.test(password) || !nameREGEX.test(name) || !teamValid() || !phoneREGEX.test(phone) || !emailValid())
        return false;
    else
        return true;
}

function empty_validation() {
    username = document.getElementById("UsernameBox").value;
    password = document.getElementById("PasswordBox").value;
    name = document.getElementById("NameBox").value;
    phone = document.getElementById("PhoneBox").value;
    email = document.getElementById("EmailBox").value;
    if (username == '' || password == '' || name == '' || phone == '' || email == '') {
        if (username == '')
            document.getElementById("UsernameLabel").innerHTML = "Username field can't be empty";
        if (password == '')
            document.getElementById("PasswordLabel").innerHTML = "Password field can't be empty";
        if (name == '')
            document.getElementById("NameLabel").innerHTML = "Name field can't be empty";
        if (phone == '')
            document.getElementById("PhoneLabel").innerHTML = "Phone field can't be empty";
        if (email == '')
            document.getElementById("EmailLabel").innerHTML = "Email field can't be empty";

        return false;
    }
    return true;
}

function usernameValid() {
    username = document.getElementById("UsernameBox").value;
    var lastASCII = username.charCodeAt(username.length - 1);
    if (lastASCII < 48 || (lastASCII > 57 && lastASCII < 65) || (lastASCII > 90 && lastASCII < 95) || (lastASCII > 95 && lastASCII > 122))
        document.getElementById("UsernameBox").value = username.substring(0, username.length - 1);

    if (!userREGEX.test(username))
        document.getElementById("UsernameLabel").innerHTML = "Username too short"; 
    else
        document.getElementById("UsernameLabel").innerHTML = "";
}

function passwordValid() {
    password = document.getElementById("PasswordBox").value;
    if (!passREGEX.test(password))
        document.getElementById("PasswordLabel").innerHTML = "Password format invalid";
    else
        document.getElementById("PasswordLabel").innerHTML = "";
}

function nameValid() {
    name = document.getElementById("NameBox").value;
    var lastASCII = name.charCodeAt(name.length - 1);
    if ((lastASCII < 65 || (lastASCII > 90 && lastASCII < 97) || lastASCII > 122) && lastASCII != 32)
        document.getElementById("NameBox").value = name.substring(0, name.length - 1);

    if (!nameREGEX.test(name))
        document.getElementById("NameLabel").innerHTML = "Invalid Name text";
    else
        document.getElementById("NameLabel").innerHTML = "";
}

function teamValid() {
    var e = document.getElementById("TeamListDropDown");
    var team = e.options[e.selectedIndex].value;
    if (team > 0 && team < 15) {
        document.getElementById("TeamListLabel").innerHTML = "";
        return true;
    }
    else {
        document.getElementById("TeamListLabel").innerHTML = "Please select some team:";
        return false;
    }
        
}

function phoneValid() {
    phone = document.getElementById("PhoneBox").value;
    var lastASCII = phone.charCodeAt(phone.length - 1);
    if (!(lastASCII > 47 && lastASCII < 58) && lastASCII != 43 && lastASCII != 45)
        document.getElementById("PhoneBox").value = phone.substring(0, phone.length - 1);

    if (!phoneREGEX.test(phone))
        document.getElementById("PhoneLabel").innerHTML = "Invalid Phone Number";
    else
        document.getElementById("PhoneLabel").innerHTML = "";

}

function emailValid() {
    email = document.getElementById("EmailBox").value;
    var lastASCII = email.charCodeAt(email.length - 1);
    if ((lastASCII < 48 || (lastASCII > 57 && lastASCII < 64) || (lastASCII > 90 && lastASCII < 95) || (lastASCII > 95 && lastASCII > 122)) && lastASCII!=46)
        document.getElementById("EmailBox").value = email.substring(0, email.length - 1);

    if (!emailREGEX.test(email))
        document.getElementById("EmailLabel").innerHTML = "Invalid Email Address Syntax";
    else
        document.getElementById("EmailLabel").innerHTML = "";


}

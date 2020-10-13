var name, datefrom, dateto, plan, seat, cost;
var nameREGEX = /^[a-zA-Z0-9]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/;

function Validation() {
    if (!empty_validation()  || !nameREGEX.test(name))
        return false;
    else
        return true;
}

function empty_validation() {
    name = document.getElementById("TourTitle").value;
    datefrom = document.getElementById("DateFromBox").value;
    dateto = document.getElementById("DateToBox").value;
    plan = document.getElementById("PlanBox").value;
    seat = document.getElementById("SeatCountBox").value;
    cost = document.getElementById("CostBox").value;
    if (name == '' || datefrom == '' || dateto == '' || plan == '' || seat == '' || cost == '') {
        if (name == '')
            document.getElementById("TourLabel").innerHTML = "Tour name field can't be empty";
        if (datefrom == '')
            document.getElementById("DateFromLabel").innerHTML = "Date can't be blank";
        else
            document.getElementById("DateFromLabel").innerHTML = "";
        if (dateto == '')
            document.getElementById("DateToLabel").innerHTML = "Date can't be blank";
        else
            document.getElementById("DateToLabel").innerHTML = "";
        if (plan == '')
            document.getElementById("PlanLabel").innerHTML = "Plan Details can't be blank";
        else
            document.getElementById("PlanLabel").innerHTML = "";
        if (seat == '')
            document.getElementById("SeatLabel").innerHTML = "Seat count can't be blank";
        else
            document.getElementById("SeatLabel").innerHTML = "";
        if (cost == '')
            document.getElementById("costLabel").innerHTML = "Cost can't be blank";
        else
            document.getElementById("costLabel").innerHTML = "";
        return false;
    }
    return true;
}

function nameValid() {
    name = document.getElementById("TourTitle").value;
    var lastASCII = name.charCodeAt(name.length - 1);
    if ((lastASCII < 48 || (lastASCII > 57 && lastASCII < 65) || (lastASCII > 90 && lastASCII < 95) || (lastASCII > 95 && lastASCII > 122)) && lastASCII != 45 && lastASCII != 32)
        document.getElementById("TourTitle").value = name.substring(0, name.length - 1);

    if (!nameREGEX.test(name))
        document.getElementById("TourLabel").innerHTML = "Invalid tour name text";
    else
        document.getElementById("TourLabel").innerHTML = "";
}

function seatValid() {
    seat = document.getElementById("SeatCountBox").value;
    var lastASCII = seat.charCodeAt(seat.length - 1);
    if (lastASCII < 48 || lastASCII > 57 || parseInt(seat) == 0 || parseInt(seat) > 10000) {
        document.getElementById("SeatCountBox").value = seat.substring(0, seat.length - 1);
    }
        
}

function costValid() {
    cost = document.getElementById("CostBox").value;
    var lastASCII = cost.charCodeAt(cost.length - 1);
    if (lastASCII < 48 || lastASCII > 57 || parseInt(cost) == 0 || parseInt(cost) > 1000000) {
        document.getElementById("CostBox").value = cost.substring(0, cost.length - 1);
    }

}
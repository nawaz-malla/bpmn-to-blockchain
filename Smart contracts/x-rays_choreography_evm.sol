// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract XRayExamChoreography {

    enum Status { DISABLED, ENABLED }
    address private patient = 0xaeD0aBbD8C55caf1247ED157C5b7c7bB4F358354;
	address private radiology = 0xaeD0aBbD8C55caf1247ED157C5b7c7bB4F358354;
	address private ward = 0xaeD0aBbD8C55caf1247ED157C5b7c7bB4F358354;

    uint8 private e0 = 1;
    uint8 private e1;
    uint8 private e2;
    uint8 private e3;
    uint8 private e4;
    uint8 private e5;
    uint8 private e6;
    uint8 private e7;
    uint8 private e8;
    uint8 private e9;
    uint8 private e10;
    uint8 private e11;
    uint8 private e12;
    uint8 private e13;
    uint8 private e14;
    uint8 private e15;
    uint8 private e16;
    uint8 private e17;
    uint8 private e18;
    uint8 private e19;

    uint8 private enabledMessages;

    Status private status_appointment = Status.DISABLED;
    string private medicalPrescription;

    Status private status_request = Status.DISABLED;
    string private requestId;

    Status private status_response = Status.DISABLED;
    bool private responseAccepted;
    string private responseDate;

    Status private status_registration = Status.DISABLED;
    string private registrationDate;
    string private appointmentId;

    Status private status_certification = Status.DISABLED;
    string private certificationId;

    Status private status_temperature = Status.DISABLED;
    string private temperatureValue;

    Status private status_checkin = Status.DISABLED;
    string private checkinAppointmentId;

    Status private status_confirmation = Status.DISABLED;
    bool private registrationConfirmation;

    Status private status_analysis = Status.DISABLED;
    string private analysis_report;
    string private ticketId;

    Status private status_report = Status.DISABLED;
    string private resultId;

    modifier onlyAuthorized(address role) {
        require(msg.sender == role, "Unauthorized: You are not allowed to call this function.");
        _;
    }

    event MessageEnabled(string from, string to, string content);
    event LogMessage(string message);

    function start1() private returns (bool)  {
        if (e0 > 0) {
            e0--;
            e1++;
            return true;
        }
        return false;
    }

    function takeAppointment() private returns (bool) {
        if (e1 > 0) {
            e1--;
            status_appointment = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("patient", "radiology", "appointment");
            return true;
        }
        return false;
    }

    function appointment(string memory _medicalPrescription) public onlyAuthorized(patient) {
        require(status_appointment == Status.ENABLED);
        medicalPrescription = _medicalPrescription;
        status_appointment = Status.DISABLED;
        enabledMessages--;
        e2++;
        execute();
    }

    function xor1() private returns (bool) {
        if (e2 > 0) {
            e2--;
            e3++;
            return true;
        } else if (e6 > 0) {
            e6--;
            e3++;
            return true;
        }
        return false;
    }

    function checkAvailability() private returns (bool) {
        if (e3 > 0) {
            e3--;
            status_request = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("radiology", "ward", "request");
            return true;
        }
        return false;
    }

    function request(string memory _requestId) public onlyAuthorized(radiology) {
        require(status_request == Status.ENABLED);
        requestId = _requestId;
        status_request = Status.DISABLED;
        enabledMessages--;
        e4++;
        execute();
    }

    function checkAvailabilityResp() private returns (bool) {
        if (e4 > 0) {
            e4--;
            status_response = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("ward", "radiology", "response");
            return true;
        }
        return false;
    }

    function response(bool _accepted, string memory _date) public onlyAuthorized(ward) {
        require(status_response == Status.ENABLED);
        responseAccepted = _accepted;
        responseDate = _date;
        status_response = Status.DISABLED;
        e5++;
        enabledMessages--;
        execute();
    }

    function xor2() private returns (bool) {
        if (e5 > 0 && !responseAccepted) {
            e5--;
            e6++;
            return true;
        } else if (e5 > 0 && responseAccepted) {
            e5--;
            e7++;
            return true;
        }
        return false;
    }

    function confirmAppointment() private returns (bool) {
        if (e7 > 0) {
            e7--;
            status_registration = Status.ENABLED;
            emit MessageEnabled("radiology", "patient", "registration");
            enabledMessages++;
            return true;
        }
        return false;
    }

    function registration(string memory _date, string memory _appointmentId) public onlyAuthorized(radiology) {
        require(status_registration == Status.ENABLED);
        registrationDate = _date;
        appointmentId = _appointmentId;
        status_registration = Status.DISABLED;
        enabledMessages--;
        e8++;
        execute();
    }

    function and1() private returns (bool) {
        if (e8 > 0) {
            e8--;
            e9++;
            e10++;
            return true;
        }
        return false;
    }

    function checkCertification() private returns (bool) {
        if (e9 > 0) {
            e9--;
            status_certification = Status.ENABLED;
            emit MessageEnabled("patient", "radiology", "certification");
            enabledMessages++;
            return true;
        }
        return false;
    }

    function certification(string memory _certificationId) public onlyAuthorized(patient) {
        require(status_certification == Status.ENABLED);
        certificationId = _certificationId;
        status_certification = Status.DISABLED;
        e11++;
        enabledMessages--;
        execute();
    }

    function checkTemperature() private returns (bool) {
        if (e10 > 0) {
            e10--;
            status_temperature = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("patient", "radiology", "temperature");
            return true;
        }
        return false;
    }

    function temperature(string memory _temp) public onlyAuthorized(patient) {
        require(status_temperature == Status.ENABLED);
        temperatureValue = _temp;
        status_temperature = Status.DISABLED;
        enabledMessages--;
        e12++;
        execute();
    }

    function and2() private returns (bool) {
        if (e11 > 0 && e12 > 0) {
            e11--;
            e12--;
            e13++;
            return true;
        }
        return false;
    }

    function checkIn() private returns (bool) {
        if (e13 > 0) {
            e13--;
            status_checkin = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("patient", "radiology", "checkin");
            return true;
        }
        return false;
    }

    function checkin(string memory _appointmentId) public onlyAuthorized(patient) {
        require(status_checkin == Status.ENABLED);
        checkinAppointmentId = _appointmentId;
        status_checkin = Status.DISABLED;
        enabledMessages--;
        e14++;
        execute();
    }

    function checkInResp() private returns (bool) {
        if (e14 > 0) {
            e14--;
            status_confirmation = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("radiology", "patient", "confirmation");
            return true;
        }
        return false;
    }

    function confirmation(bool _registration) public onlyAuthorized(radiology) {
        require(status_confirmation == Status.ENABLED);
        registrationConfirmation = _registration;
        status_confirmation = Status.DISABLED;
        enabledMessages--;
        e15++;
        execute();
    }

    function xor3() private returns (bool) {
        if (e15 > 0 && registrationConfirmation) {
            e15--;
            e16++;
            return true;
        } else if (e15 > 0 && !registrationConfirmation) {
            e15--;
            e17++;
            return true;
        }
        return false;
    }

    function end1() private returns (bool) {
        if (e17 > 0) {
            e17--;
            return true;
        }
        return false;
    }

    function performXRays() private returns (bool) {
        if (e16 > 0) {
            e16--;
            status_analysis = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("radiology", "ward", "analysis");
            return true;
        }
        return false;
    }

    function analysis(string memory _report, string memory _ticketId) public onlyAuthorized(radiology) {
        require(status_analysis == Status.ENABLED);
        analysis_report = _report;
        ticketId = _ticketId;
        status_analysis = Status.DISABLED;
        e18++;
        enabledMessages--;
        execute();
    }

    function sendResult() private returns (bool) {
        if (e18 > 0) {
            e18--;
            status_report = Status.ENABLED;
            enabledMessages++;
            emit MessageEnabled("ward", "patient", "report");
            return true;
        }
        return false;
    }

    function report(string memory _resultId) public onlyAuthorized(ward) {
        require(status_report == Status.ENABLED);
        resultId = _resultId;
        status_report = Status.DISABLED;
        e19++;
        enabledMessages--;
        execute();
    }

    function end2() private returns (bool) {
        if (e19 > 0) {
            e19--;
            return true;
        }
        return false;
    }

    function executeOneRule() private returns (bool) {
        return (start1()
            || takeAppointment()
            || xor1() 
            || checkAvailability()
            || checkAvailabilityResp()
            || xor2()
            || confirmAppointment()
            || and1()
            || checkCertification()
            || checkTemperature()
            || and2()
            || checkIn()
            || checkInResp()
            || xor3()
            || end1()
            || performXRays()
            || sendResult()
            || end2());
    }

    function getMarking() private view returns (uint8) {
        return e0 + e1 + e2 + e3 + e4 + e5 + e6 + e7 + e8 + e9 + e10 + e11 + e12 + e13 + e14 + e15 + e16 + e17 + e18 + e19;
    }

    function execute() public {
        while (executeOneRule()) {}
        if (enabledMessages > 0) {
            emit LogMessage("Waiting for message execution");
        } else {
            if (getMarking() > 0) {
                emit LogMessage("The choreography instance is DEADLOCKED");
            } else {
                emit LogMessage("The choreography instance is COMPLETE");
            }
        }
    }
}

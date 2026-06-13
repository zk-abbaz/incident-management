using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace sap.capire.incidents;

//The incidents created by customers
entity Incidents : cuid, managed {
    customer : Association to Customers;
    title : String @title : 'Title';
    urgency : Association to Urgency default 'M';
    status : Association to Status default 'N';
    conversation : Composition of many {
        key ID : UUID;
        timestamp : type of managed : createdAt;
        author : type of managed : createdBy;
        message : String;
    };
}

//The customers who create the incidents
entity Customers : managed {
    key ID : String;
    firstName : String;
    lastName : String;
    name : String = trim(firstName || ' ' || lastName);
    email : EmailAddress;
    phone : PhoneNumber;
    incidents : Association to many Incidents on incidents.customer = $self;
    creditCardNo : String(16) @assert.format : '^[1-9]\d{15}$';
    addresses : Composition of many Addresses on addresses.customer = $self;
}

//The addresses of the customers
entity Addresses : cuid, managed {
    customer : Association to Customers;
    city : String;
    postCode : String;
    streetAddress : String;
}

//The urgency of the incidents
entity Urgency : CodeList {
    key code : String enum {
        high = 'H';
        medium = 'M';
        low = 'L';
    };
}

//The status of the incidents
entity Status : CodeList {
    key code : String enum {
        new = 'N';
        assigned = 'A';
        in_process = 'I';
        on_hold = 'H';
        resolved = 'R';
        closed = 'C';
    };
    criticality : Integer;
}

type EmailAddress : String;
type PhoneNumber : String;

using {sap.capire.incidents as my} from '../db/schema';

//Service used by support personel to manage the incidents created by customers
service ProcessorService  {
    entity Incidents as projection on my.Incidents;

    @readonly
    entity Customers as projection on my.Customers;
}
annotate ProcessorService .Incidents with @odata.draft.enabled;
// annotate ProcessorService with @(requires: 'support');

//service used by admin to manage customer and the incidents
service AdminService {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
}
annotate AdminService with @(requires: 'admin');



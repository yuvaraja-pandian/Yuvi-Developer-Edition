import { LightningElement, wire } from 'lwc';
import ID_FIELD from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';
import cListView from '@salesforce/apex/cListView.accountListLWC';

const COLUMNS = [
    { label: 'ID', fieldName:  Id},
    { label: 'Name', fieldName: Name},
    { label: 'Phone', fieldName: Phone},
    { label: 'Description', fieldName: Description },
    
];
export default class AccountListView extends LightningElement {
    columns =COLUMNS ; 
    @wire(cListView)
    record;

    //result =record.data;
}
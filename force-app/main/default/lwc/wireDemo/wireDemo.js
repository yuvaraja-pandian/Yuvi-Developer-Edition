import { LightningElement, api, wire } from 'lwc';
import { getRecord , getFieldValue } from 'lightning/uiRecordApi';
export default class WireDemo extends LightningElement {

    @api recordId;

    @wire(getRecord, {recordId : '$recordId' , fields: ['Account.Name' , 'Account.Phone']})
    record;

    get AccountName1(){
        return this.record.data ? getFieldValue(this.record.data , 'Account.Name') : '';
    }

    get AccountPhone1(){
        return this.record.data ? getFieldValue(this.record.data , 'Account.Phone'):'';
    }
}
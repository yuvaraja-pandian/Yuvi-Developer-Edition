import { api, LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getObjectType from '@salesforce/apex/pathFunctionalityComponentHandler.getObjectType';
import getObjectsPicklistFields from '@salesforce/apex/pathFunctionalityComponentHandler.getObjectsPicklistFields';
import getPickList from '@salesforce/apex/pathFunctionalityComponentHandler.getPickList';
export default class pathFunctionalityComponent extends LightningElement {
    @api recordId;
    @track objectName = '';
    @track picklistOptions;
    @track optionValues = [];
    @track steps;
    @track selectedPiclistValue;
    @track currentStep; // Default active step
    @track value = '';
    @track refreshPath = false;

    connectedCallback() {
        getObjectType({recordId:this.recordId})
        .then(result =>{
            this.objectName = result;
        })
        .catch(error => {
            console.log('Error: '+error);
        });


        getObjectsPicklistFields({recordId:this.recordId})
        .then(result =>{
            this.picklistOptions = result;
            this.optionValues = result.map(item => ({ label: item, value: item }));

        }).catch(error => {
            console.log('Error: '+error);
        })       
    }

    

    

    picklistfieldsHandleChange(event) {
        this.value = event.detail.value;
        console.log('value: '+this.value);
        
        this.refreshPath = false;
        getPickList({objectName:this.objectName,fieldName:this.value})
        .then(retievedValues =>{
            this.steps = retievedValues;
            this.refreshPath = true;
        })
    }

    selectedPiclistValueHandler(event){
        this.selectedPiclistValue = event.detail.value;
        console.log('this.selectedPiclistValue : '+this.selectedPiclistValue);
    }

    showSuccessToast(msg) {
      const event = new ShowToastEvent({
            title: 'Success',
            message: msg,
            variant: 'success',
      });
      this.dispatchEvent(event);
   }

   saveHandle(){
        this.currentStep = this.selectedPiclistValue;
        this.showSuccessToast('Field updated successfully!');
   }
   

   get options() {
    return this.optionValues; 
    }
}
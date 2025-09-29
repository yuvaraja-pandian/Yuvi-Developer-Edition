import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/createAccount.AccountCreation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import {RefreshEvent} from 'lighting/refresh';
export default class TaskCreateAccount extends LightningElement {
    //Variables
    Name;
    PhoneAcc;
    RatingAcc;
    DescriptionAcc;
    ActiveAcc;
    showSpinner= false;

    //fetching inputs
    get ratingOptions() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }
   get ActiveOptions(){
    return [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
        
    ];
   }
    capture(event){
       this.Name = event.target.value;
    }

    phonecapture(event){
        this.PhoneAcc = event.target.value;
    }

    Ratingcapture(event){
        this.RatingAcc = event.target.value;
    }

    Descriptioncapture(event){
        this.DescriptionAcc = event.target.value;
    }

    Activecapture(event){
        this.ActiveAcc = event.target.value;
    }
    
     

    //event handlings
    create(){
        this.showSpinner = true;
        console.log('working');
         createAccount({name: this.Name,phone: this.PhoneAcc,rating:this.RatingAcc,description:this.DescriptionAcc,active:this.ActiveAcc})
         .then(result =>{

            
            const event = new ShowToastEvent({
                title: 'Success',
                message:'Account inserted',
                variant: 'success',
            });
            this.dispatchEvent(event);
            this.Name=null;
            this.PhoneAcc=null;
            this.RatingAcc=null;
            this.DescriptionAcc=null;
            this.ActiveAcc=null;

            
                this.showSpinner = false;
           

            

            
            //setTimeout(stopspin,2000);
        }
    )
         .catch(error=>{
            
            const event = new ShowToastEvent({
                title: 'Error',
                message:'insertion failed',
                variant: 'error',
            });
            this.dispatchEvent(event);
            this.showSpinner = false;
           
         });

         

    }
}
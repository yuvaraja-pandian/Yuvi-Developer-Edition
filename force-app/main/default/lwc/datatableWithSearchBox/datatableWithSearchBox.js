import { LightningElement,track } from 'lwc';
import getAccountList from '@salesforce/apex/DatatableWithSearchBoxHandler.getAccountList';
const columns = [
    { label: 'Id', fieldName: 'Id' ,type: 'text'},
    { label: 'Name', fieldName: 'AccountUrl', type: 'url', typeAttributes:{label:{fieldName: 'Name'},target:'_self'}},
    { label: 'Industry', fieldName: 'Industry',type: 'text' }
];
export default class DatatableWithSearchBox extends LightningElement {
    @track SearchTerm;
    @track VisibleData = [];
    @track defaultData;
    columns = columns;
    @track startingRecord = 1;
    @track endingRecord = 0 ;
    @track currentPage = 1;
    @track totalPage;
    @track totalRecordCount;
    @track pageSize = 20; // no of records to be shown in per page
    
    connectedCallback(){
        getAccountList()
        .then(result => {           
            let accParsedData = JSON.parse(JSON.stringify(result));
            accParsedData.forEach(acc => {
            acc.AccountUrl = '/'+acc.Id;
            })
            this.VisibleData = accParsedData;
            console.log(JSON.stringify(this.VisibleData));
            this.defaultData = accParsedData;
            // for pagination
            this.totalRecordCount = accParsedData.length;
            this.totalPage = Math.ceil(this.totalRecordCount/this.pageSize);
            this.VisibleData = this.defaultData.slice(0,this.pageSize);
            this.endingRecord = this.pageSize;
        })
        .catch(error => console.log(error));
    }



    //******************************************** { Onchange() event section}*************************************************************************
    searchHandler(event){
        this.SearchTerm = event.target.value;
        this.VisibleData = this.defaultData.filter(f => f.Name.toLowerCase().includes(this.SearchTerm.toLowerCase()));
        if(this.SearchTerm == ''){
            this.VisibleData = this.defaultData.slice(0,this.pageSize);
        }
    }

    //******************************************** { Onclick() event section}*************************************************************************
    previousHandler(event){
        if(this.currentPage>1){
            this.currentPage--;
            this.displayRecordPerPage(this.currentPage);

        }

    }

    nextHandler(event){
        if(this.currentPage < this.totalPage && this.currentPage != this.totalPage){
            this.currentPage++;
            this.displayRecordPerPage(this.currentPage);
        }

    }

    //******************************************** { Methods section}*************************************************************************
    displayRecordPerPage(currentPage){
        this.startingRecord = (currentPage-1)*this.pageSize;
        this.endingRecord = currentPage * this.pageSize;
        this.endingRecord = (this.endingRecord > this.totalRecordCount)?this.totalRecordCount:this.endingRecord;
        this.VisibleData = this.defaultData.slice(this.startingRecord,this.endingRecord);
    }
}
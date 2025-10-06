import { LightningElement,api } from 'lwc';

export default class Acc_EmployeeAssistanceApp extends LightningElement {

    empSeachValue ;

    updateSearchValue(event){
        this.empSeachValue = event.detail.searchValue;
    }
   
    
}
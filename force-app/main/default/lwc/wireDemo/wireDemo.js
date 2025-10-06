import { LightningElement,wire } from 'lwc';
import Id from '@salesforce/user/Id';
import USER_NAME from '@salesforce/schema/User.Name';
import USER_EMAIL from '@salesforce/schema/User.Email';
import {getRecord} from  'lightning/uiRecordApi';
const fields = [USER_NAME,USER_EMAIL]

export default class WireDemo extends LightningElement {

    userId = Id;
    userDetails;
    
    
    @wire(getRecord, {recordId: Id, fields})
   userDetailsHandler({data,error}){
       if(data){
            this.userDetails = data.fields;
       }
       if(error){
            console.log(error);
       }
    }

   @wire(getRecord, {recordId:  '$userId', fields})
    userDetailsProperty
}
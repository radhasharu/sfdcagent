import { LightningElement ,wire} from 'lwc';
import getContacts from '@salesforce/apex/ContactServer.getContacts'

export default class ContactDatatable extends LightningElement {

    @wire (getContacts)
    wiredContacts({data,error}){
        if(data){
            console.log(data.length);
        }
        else{
            console.log(error);
        }
    }
}
import { LightningElement,wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import FNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAILFIELD from '@salesforce/schema/Contact.Email'
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'FirstName', fieldName: FNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'LastName', fieldName: LNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAILFIELD.fieldApiName, type: 'email' }
];

export default class ContactList extends LightningElement {
    contactList;
    columns = COLUMNS;
    errors;
    recId = '';
    @wire(getContacts ,{recordId : '$recId'})
    contact({data,error}){
        if(data){
            this.contactList = data;
        }
    if(error){
        this.errors = reduceErrors(error);
        console.log(JSON.stringify(error));
    }
    }

    get errors() {
        return (this.contactList.error) ?
            reduceErrors(this.contactList.error) : [];
    }

    handleChange(event){
        console.log('Changed Value'+event.target.value);
    }
}
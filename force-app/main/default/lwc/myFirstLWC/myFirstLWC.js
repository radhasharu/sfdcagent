import { LightningElement,wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJ from '@salesforce/schema/Contact';
import CONTACT_FN from '@salesforce/schema/Contact.FirstName';
import CONTACT_LN from '@salesforce/schema/Contact.LastName';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import CONTACT_PHONE from '@salesforce/schema/Contact.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getContactRecords from '@salesforce/apex/GetContact.getContactList';

export default class MyFirstLWC extends LightningElement {

    contactList = [];
    handleClick() {
        // alert("this is calling");
        let firstNameValue = this.template.querySelector('.firstName').value;
        // alert("this is calling"+JSON.stringify(firstNameValue));
        let lastNameValue = this.template.querySelector('.lastName').value;
        let emailValue = this.template.querySelector('.email').value;
        let phoneValue = this.template.querySelector('.phone').value;
        let fields = {};
        fields[CONTACT_FN.fieldApiName] = firstNameValue;
        fields[CONTACT_LN.fieldApiName] = lastNameValue;
        fields[CONTACT_EMAIL.fieldApiName] = emailValue;
        fields[CONTACT_PHONE.fieldApiName] = phoneValue;
        console.log(JSON.stringify(fields));
        const recordContactInput = { apiName: CONTACT_OBJ.objectApiName, fields };
        createRecord(recordContactInput).
        then( contact => {
            console.log('contact ==>'+contact);
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Success',
                    message: 'Contact record created successfully!'+contact.Id,
                    variant: 'success',
                } ),
            );
            eval("$A.get('e.force:refreshView').fire()");
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent( {
                    title: 'Error creating Contact record',
                    message: error.body.message,
                    variant: 'error',
                } ),
            );
        })
        
    }

    @wire(getContactRecords)
    contactRecords({data,error}){
        if(data){
            this.contactList = data;
        }else{
            console.log('Error'+JSON.stringify(error));
        }
    }
}
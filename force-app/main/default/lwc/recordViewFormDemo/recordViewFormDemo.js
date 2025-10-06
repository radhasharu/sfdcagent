import { LightningElement } from 'lwc';
import CONTACT_OBJ from '@salesforce/schema/Contact';
import FNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LNAME_FIELD from '@salesforce/schema/Contact.LastName';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'

export default class RecordViewFormDemo extends LightningElement {
    objName = CONTACT_OBJ;
    fields = {
        fnameField : FNAME_FIELD,
        lnameField : LNAME_FIELD,
        phoneField : PHONE_FIELD,
        emailField :EMAIL_FIELD
    }

    handleReset(event){
        const inpFields = this.template.querySelectorAll('lightning-input-field');
        if(inpFields){
            Array.from(inpFields).forEach(item => {item.reset();})
        }
    }
}
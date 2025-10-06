import { LightningElement } from 'lwc';
import PSFILE from "@salesforce/resourceUrl/PermissionSetAssignment";
import { NavigationMixin } from 'lightning/navigation';

export default class PermissionSetFileAssignment extends NavigationMixin(LightningElement) {

    fileUrl = PSFILE;

    get acceptedFormats() {
        return ['.pdf', '.png'];
    }
    
    downloadPSFile() {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: this.fileUrl
            }
        }, false
        );
    }
}
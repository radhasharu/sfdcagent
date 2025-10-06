import { LightningElement } from 'lwc';

export default class SlotChildDemo extends LightningElement {

    handleSlotChange(){
        const footerElem = this.template.querySelector('.city');
        if(footerElem){
            footerElem.classList.remove('slds-hide');
        }
    }
}
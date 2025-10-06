import { LightningElement,api } from 'lwc';

export default class Cmp_CollapsibleSection extends LightningElement {
    @api sectionHeader;
    @api body;
    
        toggleSection (event) {
    
            var sectionState = this.template.querySelector('span').getAttribute('class').search('slds-is-open');
    
            if(sectionState === -1){
                this.template.querySelector('span').setAttribute('class' , 'slds-section slds-is-open');
            }else{
                this.template.querySelector('span').setAttribute('class' , 'slds-section slds-is-close');
            }
    
        }
}
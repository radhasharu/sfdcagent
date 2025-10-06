import { LightningElement,api } from 'lwc';

export default class P2cAlertComponent extends LightningElement {

    @api message;
    @api cardHeading;
    @api numberValue;
    @api isValid;
    @api isValidtrue;

  

    changeHandler(event){
        this.message = event.target.value;
    }
}
import { LightningElement ,wire} from 'lwc';
import SampleLMC from '@salesforce/messageChannel/SampleMessageChannel__c';
import { APPLICATION_SCOPE,publish,subscribe,unsubscribe,MessageContext } from 'lightning/messageService';

export default class LmsComponentA extends LightningElement {

    enteredVal;
    @wire(MessageContext)
    context;

    inputHandler(event){
        this.enteredVal = event.target.value;

    }

    publishMesage(event){
        const message = {
            lmsData : {
                value : this.enteredVal
            }
        }
        publish(this.context, SampleLMC, message);
    }
}
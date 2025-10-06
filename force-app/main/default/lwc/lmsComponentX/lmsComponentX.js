import { LightningElement, wire } from 'lwc';
import SampleLMC from '@salesforce/messageChannel/SampleMessageChannel__c';
import { APPLICATION_SCOPE, publish, subscribe, unsubscribe, MessageContext } from 'lightning/messageService';

export default class LmsComponentX extends LightningElement {
    receieveMessage;
    subscription;
    @wire(MessageContext)
    context;

    connectedCallback(){
        this.subscribeMessage();
    }
    subscribeMessage() {
        this.subscription = subscribe(this.context, SampleLMC, (message) => { this.handleMessage(message) }, { scope: APPLICATION_SCOPE })
    }

    handleMessage(message){
        this.receieveMessage = message.lmsData.value ? message.lmsData.value : 'No Message';
    }

    unsubscribeMesage(){
        unsubscribe(this.subscription);
    }

}
import { LightningElement,api } from 'lwc';
import {FlowNavigationNextEvent} from 'lightning/flowSupport';
export default class TimeComp extends LightningElement {
    @api duration = 40; // Default duration in seconds
    @api availableActions = [];
    timeLeft;
    isDisabled = true;
    connectedCallback() {
        this.timeLeft = this.duration;

        const interval = setInterval(() => {
            this.timeLeft -= 1;

            if (this.timeLeft === 0) {
                clearInterval(interval);
                this.isDisabled = false;
                // Dispatch the 'navigateNext' event to move to the next step in the flow
                    const navigateNextEvent = new FlowNavigationNextEvent();
                    this.dispatchEvent(navigateNextEvent);
                
                
            }
        }, 1000);
    }

}
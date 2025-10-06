import { LightningElement, api } from 'lwc';

export default class LwcAuraCommunication extends LightningElement {

    @api title;

    callAura(event) {
        this.dispatchEvent(new CustomEvent('sendMsg', {
            detail: {
                'msg': "Hello from LWc through Event"
            }
        })
        )
    }
}
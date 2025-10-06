import { LightningElement } from 'lwc';

export default class C2pModelComponent extends LightningElement {

    closeModal(event){
        /*const closeEvent = new CustomEvent('close',{
            detail: "Model Closed Successfully"
        });*/
        console.log('Model Event Calleed');
        const closeEvent = new CustomEvent('close',{
            bubbles:true,
            detail: {
                msg : 'Modal Closed Successfully'
            }
        });
        this.dispatchEvent(closeEvent);
    }

    footerHandler(){
        console.log('Footer event Called')
    }
}
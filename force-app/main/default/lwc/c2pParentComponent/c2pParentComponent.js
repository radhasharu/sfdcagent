import { LightningElement } from 'lwc';

export default class C2pParentComponent extends LightningElement {
    showModel = false;
    msg;
    handleClick(event){
        this.showModel = true;
    }

    closeModal(event){
        console.log('div event called');
       // this.msg = event.detail;
       this.msg = event.detail.msg;
        this.showModel = false;
        

    }
}
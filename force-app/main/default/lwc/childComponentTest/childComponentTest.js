import { LightningElement, track } from 'lwc';
 
export default class ChildComponentTest extends LightningElement {  
 
    constructor(){
        super(); //Calling Constructor of LightningElement
        console.log('Constructor called =>');
    }
 
    connectedCallback() {
        console.log('Connected callback child called =>');
    }
 
    renderedCallback(){        
        console.log('Child Component renderedCallback from Parent Component =>');
    }
   
}
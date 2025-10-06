import { LightningElement } from 'lwc';

export default class HelloQuerySelectorDemo extends LightningElement {

    userNames = ['Radha', 'Neha', 'Suman'];
    fetchDetailHanlder(){
        const elem = this.template.querySelector('h1');
        elem.style.border = '1px solid red';

        console.log(elem.innerText);
        const userElem = this.template.querySelectorAll('.name');
        Array.from(userElem).forEach(item =>{
            item.setAttribute('title',item.innerText);
            console.log(item.innerText);
        })

        //lwc:dom = 'manual' demo
        const childElem =  this.template.querySelector('.child');
        childElem.innerHTML = '<p> I am child Element </p>';
        
    }
}
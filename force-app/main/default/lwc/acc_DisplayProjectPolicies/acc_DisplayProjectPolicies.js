import { LightningElement,wire,track } from 'lwc';
import getAllProjPolicies from '@salesforce/apex/ACC_EmployeeAssistanceController.getAllProjPolicies'

export default class Acc_DisplayProjectPolicies extends LightningElement {
    activeSectionName = [];
    @track projectPolicyList = [];

    policyColumns = [
        { label: 'Policy Number', fieldName: 'Name' ,hideDefaultActions: true},
        { label: 'Policy Details', fieldName: 'Policy_Name__c',hideDefaultActions: true },
        { label: 'Policy Status', fieldName: 'Policy_Status__c',hideDefaultActions: true }
    ];

    handleToggleSection(event) {
        console.log(event.detail.openSections);
    }


    
    @wire(getAllProjPolicies)
    policiesHandler({data,error}){
        if(data){
            data.forEach((item) =>{
                this.activeSectionName.push(item.Project__r.Name);
                if(this.projectPolicyList.find((projPol) => projPol.pname === item.Project__r.Name)){ // check if the Object already contains project
                   let policy = this.projectPolicyList.find((projPol) => projPol.pname === item.Project__r.Name).policies; // if yes, get the policies of thr project
                   this.projectPolicyList = this.projectPolicyList.filter((projPol) =>projPol.pname !== item.Project__r.Name); // filter object to remove the project
                    this.projectPolicyList = [...this.projectPolicyList,{   // add the project with updated policies to the object
                        'pname': item.Project__r.Name,
                        'policies': [...policy,item]
                    }]
                }
                else{
                
                    let policy = [];
                    this.projectPolicyList = [...this.projectPolicyList,{
                        'pname': item.Project__r.Name,
                        'policies': [...policy,item]
                    }]
    
                }
               
            });
            
        }
        if(error){
            console.log('Error occured in getAllProjPolicies ==>'+JSON.stringify(error));
        }

    }
}
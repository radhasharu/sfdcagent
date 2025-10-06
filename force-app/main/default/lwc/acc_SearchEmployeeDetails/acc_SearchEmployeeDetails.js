import { LightningElement, track } from 'lwc';
import getEmployeeDetails from '@salesforce/apex/ACC_EmployeeAssistanceController.getEmployeeDetails'
import EMP_ID from '@salesforce/schema/ACC_Employee__c.Name'
import EMP_NAME from '@salesforce/schema/ACC_Employee__c.Employee_Name__c'
import EMP_EMAIL from '@salesforce/schema/ACC_Employee__c.Email__c'
import EMP_PHONE from '@salesforce/schema/ACC_Employee__c.Phone__c'
import EMP_PSKILL from '@salesforce/schema/ACC_Employee__c.Primary_Skill__c'
import EMP_SSKILL from '@salesforce/schema/ACC_Employee__c.Secondary_Skill__c'
import EMP_PROJ_NAME from '@salesforce/schema/ACC_Employee__c.Project__c'
import EMP_OBJECT from '@salesforce/schema/ACC_Employee__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Acc_SearchEmployeeDetails extends LightningElement {

    employeeId;
    employeeFound = false;
    employeeNotFound = false;
    fields = [EMP_ID, EMP_NAME, EMP_EMAIL, EMP_PHONE, EMP_PSKILL, EMP_SSKILL, EMP_PROJ_NAME];
    objApiName = EMP_OBJECT;
    formMode = 'readonly';
    showSpinner = false;


    get isReadOnlyMode() {
        return this.formMode === 'readonly';
    }

    handleSearchEmployee() {
        this.showSpinner = true;
        let searchValue = this.refs.searchElem.value;
        if (searchValue) {
            getEmployeeDetails({ empId: searchValue })
                .then(result => {

                    if (result.length > 0) {
                        this.employeeId = result[0].Id;
                        this.employeeFound = true;
                        this.employeeNotFound = false;
                        this.dispatchEvent(new CustomEvent('refreshtable', {
                            detail: {
                                searchValue: searchValue
                            }
                        }));
                    }
                    else {
                        this.employeeNotFound = true;
                        this.employeeFound = false;
                    }
                    this.showSpinner = false;

                })
                .catch(error => {
                    console.log('error==>' + error);
                    this.showSpinner = false;

                })
        }
        else {
            this.employeeFound = false;
            this.employeeNotFound = false;
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Please enter Employee Id',
                variant: 'error',
            });
            this.dispatchEvent(evt);
            this.showSpinner = false;
        }

    }

    handleEnableEdit() {
        this.formMode = 'edit';
    }

    handleCancel() {
        this.formMode = 'readonly';
    }

    handleSuccess(event) {
        this.showSpinner = true;
        this.formMode = 'readonly';
        const evt = new ShowToastEvent({
            title: 'Update Success',
            message: 'Employee Details Updated Successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.showSpinner = false;
    }


}
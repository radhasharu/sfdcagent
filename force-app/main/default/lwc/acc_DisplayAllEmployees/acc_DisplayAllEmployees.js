import { LightningElement, wire, api } from 'lwc';
import getAllEmployees from '@salesforce/apex/ACC_EmployeeAssistanceController.getAllEmployees'
import { refreshApex } from '@salesforce/apex'

export default class Acc_DisplayAllEmployees extends LightningElement {

    showSpinner = false;
    employeeColumns = [
        { label: 'Employee Id', fieldName: 'Name' ,hideDefaultActions: true},
        { label: 'Employee Name', fieldName: 'Employee_Name__c' ,hideDefaultActions: true},
        { label: 'Project Name', fieldName: 'ProjectName' ,hideDefaultActions: true},
        { label: 'Phone Number', fieldName: 'Phone__c', type: 'phone' ,hideDefaultActions: true},
        { label: 'Email Address', fieldName: 'Email__c', type: 'email',hideDefaultActions: true },
        { label: 'Primary Skill', fieldName: 'Primary_Skill__c',hideDefaultActions: true },
        { label: 'Secondary Skill', fieldName: 'Secondary_Skill__c' ,hideDefaultActions: true}
    ];
    employeeData;
    tempEmployeeData;
    visibleEmployeeData;
    displayTable = false;
    currentPage = 1;
    totalPage = 0;
    pageSize = 5;
    wireEmployeeData;
    isRendered = true;
    _searchEmpId;
    oldSearchEmpId;

    @api
    get searchEmpId() {
        console.log('getter called');
        return this._searchEmpId;
    }
    set searchEmpId(value) {
        console.log('setter called');
        this.oldSearchEmpId = this._searchEmpId;
        this._searchEmpId = value;
       this.isRendered = true;
    }


    @wire(getAllEmployees)
    employeesHandler(wireResult) {
        const { data, error } = wireResult;
        this.wireEmployeeData = wireResult;
        if (data) {
            this.displayTable = true;
            this.employeeData = data.map(value => {
                return { ...value, ProjectName: value.Project__r.Name }
            });
            this.tempEmployeeData = this.employeeData;
            this.totalPage = Math.ceil(data.length / this.pageSize);
            this.getVisbileRecords();
        }
        if (error) {
            this.displayTable = false;
            console.log('Error occured in getAllEmployees ==>' + JSON.stringify(error));
        }

    }



    getVisbileRecords() {
        const start = (this.currentPage - 1) * this.pageSize;
        const end = this.pageSize * this.currentPage;
        this.visibleEmployeeData = this.employeeData.slice(start, end);

    }

    get disablePrevious() {
        return this.currentPage <= 1;
    }
    get disableNext() {
        return this.currentPage >= this.totalPage;
    }
    previousHandler() {
        if (this.currentPage > 1) {
            this.currentPage = this.currentPage - 1
            this.getVisbileRecords()
        }
    }
    nextHandler() {
        if (this.currentPage < this.totalPage) {
            this.currentPage = this.currentPage + 1;
            this.getVisbileRecords()
        }
    }

    handleSearchChange() {
        this.showSpinner = true;
        let searchValue = this.refs.searchElem.value;
        if (searchValue.length >= 3) {
            let searchedEmployeeData = this.tempEmployeeData.filter(
                (emp) => emp.Name.includes(searchValue)); // filter tempEmployeeData to find the employee with searched employee number
            let searchedProjectList = searchedEmployeeData.map((employee) =>
                employee.ProjectName
            ); // get the project name for the searched employee number
            this.employeeData = this.tempEmployeeData.filter(
                (emp) => searchedProjectList.includes(emp.ProjectName)); // filter tempEmployeeData to find the employees of the searched employee number project

            this.totalPage = Math.ceil(this.employeeData.length / this.pageSize);
            this.currentPage = 1;
            this.getVisbileRecords();
        }
        if (!searchValue || searchValue.length === 0) {
            this.employeeData = this.tempEmployeeData;
            this.totalPage = Math.ceil(this.employeeData.length / this.pageSize);
            this.currentPage = 1;
            this.getVisbileRecords();
        }
        this.showSpinner = false;

    }

    async refreshDatatable() {
        this.showSpinner = true;
        await refreshApex(this.wireEmployeeData).then(
            (data) => {
                console.log('Refresh Apex successfull');
              
            }).catch(
                (error) => {
                    console.log('Error occured in refreshDatatable ==>' + JSON.stringify(error));
                })
        if (this.searchEmpId) {
            this.handleSearchChange();
        }
        this.showSpinner = false;
    }

    renderedCallback() {
        console.log('Rendered callback called');
        if (this.isRendered && this.searchEmpId && this.refs.searchElem) {
            console.log('Rendered callback inside');
            this.handleSearchChange();
            this.isRendered = false;
        }
        
    }
}
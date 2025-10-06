import { LightningElement, track } from 'lwc';
import getUsers from '@salesforce/apex/PermissionSetAssignmentController.getUsers'
import getPS from '@salesforce/apex/PermissionSetAssignmentController.getPS'
import assignPS from '@salesforce/apex/PermissionSetAssignmentController.assignPS'
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
export default class PermissionSetAssignment extends LightningElement {
    @track optionDataUser = [];
    showDropdownUser = false;
    messageUser;
    searchStringUser;
    @track optionDataPS = [];
    showDropdownPS = false;
    messagePS;
    searchStringPS;
    minChar = 2;
    @track tableData = [];
    resultData = [];
    showTable = false;
    userSearchField;
    psSearchField;
    currentPage = 1;
    disPrev = false;
    disNext = false;
    offset = 0;
    limit = 5;
    maxPageSize = 5;
    tempData = [];
    totalPages = 0;
    userPlaceHolder ;
    psPlaceHolder ;
    userSearchOptions = [
        { label: 'Id', value: 'Id' },
        { label: 'Name', value: 'Name' },
        { label: 'Username', value: 'Username' },
        { label: 'Email', value: 'Email' }
    ];
    psSearchOptions = [
        { label: 'Id', value: 'Id' },
        { label: 'Label', value: 'label' },
        { label: 'Name', value: 'Name' }
    ];

    tableColumns = [
        { label: 'USER Id', fieldName: 'userId' },
        { label: 'USERNAME', fieldName: 'userName' },
        { label: 'PERMISSION SET ID', fieldName: 'psId' },
        { label: 'PERMISSION SET NAME', fieldName: 'psName' },
        { label: 'RESULT', fieldName: 'result' }
    ];

    connectedCallback() {
        document.title = 'Permission Set Assignment';
    }
    get disabledUserInput() {
        return this.userSearchField ? false : true;
    }
    get disabledPSInput() {
        return this.psSearchField ? false : true;
    }
    get disableButton() {
        var countPS = 0;
        var countUser = 0;
        var options = JSON.parse(JSON.stringify(this.optionDataUser));
        var optionsPS = JSON.parse(JSON.stringify(this.optionDataPS));
        if (options.length == 0) {
            return true;
        }
        else {
            for (var i = 0; i < options.length; i++) {
                if (options[i].selected) {
                    countUser++;
                }
            }

            for (var i = 0; i < optionsPS.length; i++) {
                if (optionsPS[i].selected) {
                    countPS++;
                }
            }
            if (countUser == 0 || countPS == 0) {
                return true;
            }
            if (countUser > 0 && countPS > 0) {
                return false;
            }


        }


    }

    handleUserSearchFieldChange(event) {
        this.userSearchField = event.target.value;
        this.userPlaceHolder = 'Enter User ' + event.target.value;
    }
    handlePSSearchFieldChange(event) {
        this.psSearchField = event.target.value;
        this.psPlaceHolder = 'Enter Permission Set ' + event.target.value;
    }
    filterUsers(event) {
        this.searchStringUser = event.target.value;
        this.messageUser = '';
        if (this.searchStringUser && this.searchStringUser.length > 0 && this.searchStringUser.length > this.minChar) {
            if (this.searchStringUser.trim().startsWith('005')) {
                this.searchStringUser = this.searchStringUser.trim();
            }
            else {
                this.searchStringUser = this.searchStringUser.toLowerCase().trim();
            }

            var selectedoptionsList = [];
            var selectedoptionsValue = [];
            var options = JSON.parse(JSON.stringify(this.optionDataUser));
            for (var i = 0; i < options.length; i++) {
                if (options[i].selected) {
                    selectedoptionsList.push(options[i]);
                    selectedoptionsValue.push(options[i].value);
                }
            }

            getUsers({ searchString: this.searchStringUser, userSearchField: this.userSearchField })
                .then(data => {
                    var optionsList = [];
                    if (data && data.length > 0) {
                        data.forEach((record) => {
                            if (!selectedoptionsValue.includes(record.Id)) {
                                optionsList.push({
                                    'label': record.Username + ' => ' + record.Email,
                                    'value': record.Id,
                                    'isVisible': true
                                })
                            }

                        })
                        if (selectedoptionsList.length > 0) {
                            selectedoptionsList.forEach((selectedRecord) => {
                                optionsList.push({
                                    'label': selectedRecord.label,
                                    'value': selectedRecord.value,
                                    'isVisible': true,
                                    'selected': true
                                })
                            })

                        }

                        this.optionDataUser = optionsList;
                        this.showDropdownUser = true;

                    }
                    else {
                        this.showDropdownUser = true;
                        this.messageUser = "No results found for '" + this.searchStringUser + "'";
                    }
                })
                .catch(error => {
                    console.log('Error in fetching users' + error);

                })


        } else {
            this.showDropdownUser = false;
        }
    }


    selectItemUser(event) {
        var selectedVal = event.currentTarget.dataset.id;
        if (selectedVal) {
            var count = 0;
            var options;
            options = JSON.parse(JSON.stringify(this.optionDataUser));
            for (var i = 0; i < options.length; i++) {
                if (options[i].value === selectedVal) {
                    options[i].selected = options[i].selected ? false : true;

                }
                if (options[i].selected) {
                    count++;
                }
            }
            this.optionDataUser = options;
            event.preventDefault();

        }
    }

    blurEventUser() {
        var previousLabel;
        var count = 0;
        for (var i = 0; i < this.optionDataUser.length; i++) {
            if (this.optionDataUser[i].value === this.value) {
                previousLabel = this.optionDataUser[i].label;
            }
            if (this.optionDataUser[i].selected) {
                count++;
            }
        }
        this.showDropdownUser = false;
    }

    removePillUser(event) {
        var value = event.currentTarget.name;
        var count = 0;
        var options = JSON.parse(JSON.stringify(this.optionDataUser));
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === value) {
                options[i].selected = false;
            }

            if (options[i].selected) {
                count++;
            }
        }
        this.optionDataUser = options;
    }

    filterPS(event) {
        this.searchStringPS = event.target.value;
        this.messagePS = '';
        if (this.searchStringPS && this.searchStringPS.length > 0 && this.searchStringPS.length > this.minChar) {
            if (this.searchStringPS.trim().startsWith('0PS')) {
                this.searchStringPS = this.searchStringPS.trim();
            }
            else {
                this.searchStringPS = this.searchStringPS.toLowerCase().trim();
            }
            var selectedoptionsList = [];
            var selectedoptionsValue = [];
            var options = JSON.parse(JSON.stringify(this.optionDataPS));
            for (var i = 0; i < options.length; i++) {
                if (options[i].selected) {
                    selectedoptionsList.push(options[i]);
                    selectedoptionsValue.push(options[i].value);
                }
            }


            getPS({ searchString: this.searchStringPS, psSearchField: this.psSearchField })
                .then(data => {
                    var optionsList = [];
                    if (data && data.length > 0) {
                        data.forEach((record) => {
                            if (!selectedoptionsValue.includes(record.Id)) {
                                optionsList.push({
                                    'label': record.Name,
                                    'value': record.Id,
                                    'isVisible': true
                                })
                            }
                        })
                        if (selectedoptionsList.length > 0) {
                            selectedoptionsList.forEach((selectedRecord) => {
                                optionsList.push({
                                    'label': selectedRecord.label,
                                    'value': selectedRecord.value,
                                    'isVisible': true,
                                    'selected': true
                                })
                            })

                        }

                        this.optionDataPS = optionsList;
                        this.showDropdownPS = true;

                    }
                    else {
                        this.showDropdownPS = true;
                        this.messagePS = "No results found for '" + this.searchStringPS + "'";
                    }
                })
                .catch(error => {
                    console.log('Error in fetching Permission Sets' + error);

                })


        } else {
            this.showDropdownPS = false;
        }
    }


    selectItemPS(event) {
        var selectedVal = event.currentTarget.dataset.id;
        if (selectedVal) {
            var count = 0;
            var options;
            options = JSON.parse(JSON.stringify(this.optionDataPS));
            for (var i = 0; i < options.length; i++) {
                if (options[i].value === selectedVal) {
                    options[i].selected = options[i].selected ? false : true;

                }
                if (options[i].selected) {
                    count++;
                }
            }
            this.optionDataPS = options;
            event.preventDefault();

        }
    }

    blurEventPS() {
        var previousLabel;
        var count = 0;
        for (var i = 0; i < this.optionDataPS.length; i++) {
            if (this.optionDataPS[i].value === this.value) {
                previousLabel = this.optionDataPS[i].label;
            }
            if (this.optionDataPS[i].selected) {
                count++;
            }
        }
        this.showDropdownPS = false;
    }

    removePillPS(event) {
        var value = event.currentTarget.name;
        var count = 0;
        var options = JSON.parse(JSON.stringify(this.optionDataPS));
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === value) {
                options[i].selected = false;
            }

            if (options[i].selected) {
                count++;
            }
        }
        this.optionDataPS = options;
    }

    resetForm(event) {
        var options = JSON.parse(JSON.stringify(this.optionDataUser));
        for (var i = 0; i < options.length; i++) {

            if (options[i].selected) {
                options[i].selected = false;
            }
        }

        var optionsPS = JSON.parse(JSON.stringify(this.optionDataPS));
        for (var i = 0; i < optionsPS.length; i++) {

            if (optionsPS[i].selected) {
                optionsPS[i].selected = false;
            }
        }
        this.optionDataUser = options;
        this.searchStringUser = '';
        this.optionDataPS = optionsPS;
        this.searchStringPS = '';
        this.showTable = false;

    }

    assignPS(event) {
        this.currentPage = 1;
        this.totalPages = 0;
        this.offset = 0;
        this.limit = this.maxPageSize;
        this.disNext = false;
        this.disPrev = false;
        this.showTable = false;
        this.tableData = [];
        this.resultData = [];
        var selectedUsers = [];
        var selectedPS = [];
        var options = JSON.parse(JSON.stringify(this.optionDataUser));
        for (var i = 0; i < options.length; i++) {
            if (options[i].selected) {
                selectedUsers.push(options[i].value);
            }

        }
        var optionsPS = JSON.parse(JSON.stringify(this.optionDataPS));
        for (var i = 0; i < optionsPS.length; i++) {

            if (optionsPS[i].selected) {
                selectedPS.push(optionsPS[i].value);
            }
        }

        assignPS({ selectedUsers: selectedUsers, selectedPS: selectedPS })
            .then(data => {
                this.showTable = true;
                this.tempData = data;
                if (data.length > 5) {
                    this.tableData = data.slice(this.offset, this.limit);
                    this.totalPages = Math.ceil(data.length / this.limit);
                }
                else {
                    this.totalPages = 1;
                    this.tableData = data;
                    this.disPrev = true;
                    this.disNext = true;
                }

                this.resultData = data;
                const evt = new ShowToastEvent({ title: 'Success', message: 'Operation Success', variant: 'success' })
                this.dispatchEvent(evt);

            })
            .catch(error => {
                const evt1 = new ShowToastEvent({ title: 'Error', message: error, variant: 'error' })
                this.dispatchEvent(evt1);
                console.log('Error in Assigning PS' + error);

            })

    }

    handleNextPage(event) {
        this.offset = this.offset + this.maxPageSize;
        this.limit = this.limit + this.maxPageSize;
        this.tableData = this.tempData.slice(this.offset, this.limit);
        this.currentPage = this.currentPage + 1;
        if (this.currentPage == this.totalPages) {
            this.disNext = true;
            this.disPrev = false;
        }
    }
    handlePreviousPage(event) {
        this.offset = this.offset - this.maxPageSize;
        this.limit = this.limit - this.maxPageSize;
        this.tableData = this.tempData.slice(this.offset, this.limit);
        this.currentPage = this.currentPage - 1;
        if (this.currentPage == 1) {
            this.disPrev = true;
            this.disNext = false;
        }
    }

    downloadResult(event) {

        var data = this.resultData
        let rowEnd = '\n';
        let csvString = '';
        let header = {
            USER_ID: 'userId',
            USERNAME: 'userName',
            PERMISSION_SET_ID: 'psId',
            PERMISSION_SET_NAME: 'psName',
            RESULT: 'result'
        }

        let rowData = new Set();
        rowData.add('USER_ID');
        rowData.add('USERNAME');
        rowData.add('PERMISSION_SET_ID');
        rowData.add('PERMISSION_SET_NAME');
        rowData.add('RESULT');
        rowData = Array.from(rowData);
        csvString += rowData.join(',');
        csvString += rowEnd;
        for (let i = 0; i < data.length; i++) {
            let colValue = 0;
            for (let key in rowData) {
                if (rowData.hasOwnProperty(key)) {
                    let rowKey = header[rowData[key]];

                    if (colValue > 0) {
                        csvString += ',';
                    }

                    let value = data[i][rowKey] === undefined ? '' : data[i][rowKey];
                    csvString += '"' + value + '"';
                    colValue++;
                }
            }
            csvString += rowEnd;
        }

        let downloadElement = document.createElement('a');
        downloadElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvString);
        downloadElement.target = '_self';
        downloadElement.download = 'PermissionSet Assignment.csv';
        document.body.appendChild(downloadElement);
        downloadElement.click();


    }

}
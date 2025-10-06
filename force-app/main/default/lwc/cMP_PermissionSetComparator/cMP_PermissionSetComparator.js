import { LightningElement, wire, track } from 'lwc';
import getAllPermissionSet from '@salesforce/apex/CMP_PermissionSetComparator.getAllPermissionSets'
import getSinglePermissionSet from '@salesforce/apex/CMP_PermissionSetComparator.getSinglePermissionSetDetails'
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import SheetJS from '@salesforce/resourceUrl/SheetJS'; // The static resource for SheetJS


export default class CMP_PermissionSetComparator extends LightningElement {

    @track permissionsetList;


    async connectedCallback() {
        await loadScript(this, SheetJS); // load the library
        // At this point, the library is accessible with the `XLSX` variable
        this.version = XLSX.version;
        console.log('version: ' + this.version);
    }


    @wire(getAllPermissionSet)
    permissionSetDetails({ data, error }) {
        if (data) {
            console.log('data' + JSON.stringify(data))
            this.permissionsetList = data;
        }
        if (error) {
            console.log('Error' + JSON.stringify(error))

        }
    }

    getPermissionSetDetails() {
        var filename = 'PermissionSetPermissions.xlsx';
        const workbook = XLSX.utils.book_new();
        var headers = [];
        var permissionId = this.template.querySelector("select[data-my-id=PermissionSet]").value;

        if (!permissionId) {
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Please Select the Permission Set',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            return;
        }
        for (let i = 0; i < this.permissionsetList.length; i++) {
            if (this.permissionsetList[i].Id === permissionId) {
                filename = this.permissionsetList[i].Label + '.xlsx';
            }

        }
        console.log('permissionId==>' + permissionId);
        getSinglePermissionSet({ psId: permissionId })
            .then(data => {
                console.log(data);
                if (data) {

                    if (data['Object Permissions'] && data['Object Permissions'].length > 0) {
                        headers = ['Object', 'Create', 'Edit', 'Read', 'Delete', 'View All', 'Modify All'];
                        var objectPermissionsList = [];
                        data['Object Permissions'].forEach((record) => {
                            objectPermissionsList.push({
                                'Object': record.SobjectType,
                                'Create': record.PermissionsCreate,
                                'Edit': record.PermissionsEdit,
                                'Read': record.PermissionsRead,
                                'Delete': record.PermissionsDelete,
                                'View All': record.PermissionsViewAllRecords,
                                'Modify All': record.PermissionsModifyAllRecords
                            })

                        })
                        const worksheet = XLSX.utils.json_to_sheet(objectPermissionsList, { header: headers });
                        XLSX.utils.book_append_sheet(workbook, worksheet, 'Object Permissions');

                    }
                    if (data['Field Permissions'] && data['Field Permissions'].length > 0) {
                        headers = ['Object', 'Field', 'Edit', 'Read'];
                        var fieldPermissionsList = [];
                        data['Field Permissions'].forEach((record) => {
                            fieldPermissionsList.push({
                                'Object': record.SobjectType,
                                'Field': record.Field,
                                'Edit': record.PermissionsEdit,
                                'Read': record.PermissionsRead
                            })

                        })
                        const worksheet = XLSX.utils.json_to_sheet(fieldPermissionsList, { header: headers });
                        XLSX.utils.book_append_sheet(workbook, worksheet, 'Field Permissions');

                    }
                    if (data['ApexClass Access'] && data['ApexClass Access'].length > 0) {
                        headers = ['Id', 'Name',];
                        var apexPermissionsList = [];
                        data['ApexClass Access'].forEach((record) => {
                            apexPermissionsList.push({
                                'Id': record.Id,
                                'Name': record.Name
                            })

                        })
                        const worksheet = XLSX.utils.json_to_sheet(apexPermissionsList, { header: headers });
                        this.styleSheetHeader(worksheet);
                        XLSX.utils.book_append_sheet(workbook, worksheet, 'ApexClass Access');

                    }




                    const excelBuffer = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
                    const blob = new Blob([excelBuffer], { type: 'application/octet-stream' });

                    // Create a download link and click it programmatically to initiate the download
                    const a = document.createElement('a');
                    a.href = URL.createObjectURL(blob);
                    a.download = filename;
                    a.click();

                    // Release the object URL to free up memory
                    URL.revokeObjectURL(a.href);
                }
                else {
                    const event = new ShowToastEvent({
                        title: 'Error',
                        message: 'There are no permissions available for this Permission Set',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(event);


                }

            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: 'There are no permissions available for this Permission Set',
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);


            })

    }

    styleSheetHeader(ws) {
        const headerStyle = { font: { bold: true } };
        const range = XLSX.utils.decode_range(ws['!ref']);
        for (let col = range.s.c; col <= range.e.c; col++) {
            const cellAddress = { c: col, r: range.s.r };
            const cellRef = XLSX.utils.encode_cell(cellAddress);
            if (ws[cellRef]) {
                if (!ws[cellRef].s) {
                    ws[cellRef].s ={}
                }
            }
            ws[cellRef].s = {...ws[cellRef].s, ...headerStyle};

        }

    }


}
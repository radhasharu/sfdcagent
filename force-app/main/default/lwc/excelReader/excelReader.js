import { LightningElement } from 'lwc';
import SheetJS from '@salesforce/resourceUrl/SheetJS'; // Import the SheetJS library
import { loadScript } from 'lightning/platformResourceLoader';
import createRecords from '@salesforce/apex/ExcelRecordHandler.createRecords';

export default class ExcelReader extends LightningElement {
    sheetJsInitialized = false;

    async connectedCallback() {
        await loadScript(this, SheetJS); // load the library
        // At this point, the library is accessible with the `XLSX` variable
        this.version = XLSX.version;
        console.log('version: ' + this.version);
    }

    handleFileChange(event) {
        const file = event.target.files[0];
        if (file) {
            this.readExcelFile(file);
        }
    }

    readExcelFile(file) {
                this.processFile(file);
    }

    processFile(file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            const data = new Uint8Array(e.target.result);
            const workbook = XLSX.read(data, { type: 'array' });
            const sheetName = workbook.SheetNames[0];
            const worksheet = workbook.Sheets[sheetName];
            const jsonData = XLSX.utils.sheet_to_json(worksheet);
            console.log('JSON Data:', JSON.stringify(jsonData, null, 2)); // Properly log the JSON data
            this.createRecords(jsonData);
        };
        reader.onerror = (error) => {
            console.error('Error reading file:', error);
        };
        reader.readAsArrayBuffer(new Blob([file])); // Ensure file is treated as a Blob
    }

    createRecords(data) {
        createRecords({ jsonData: JSON.stringify(data) })
            .then(result => {
                console.log('Records created successfully');
            })
            .catch(error => {
                console.error('Error creating records:', error);
            });
    }
}
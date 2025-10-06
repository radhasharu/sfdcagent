import { LightningElement } from 'lwc';
import ACCOUNT_OBJ from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class RecordFormDemo extends LightningElement {
    objectName = ACCOUNT_OBJ;
    fieldList = [NAME_FIELD, ANNUAL_REVENUE_FIELD, TYPE_FIELD, INDUSTRY_FIELD];

    successHandler(event) {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Account Created',
            message: 'Record ID' + event.detail.id,
            variant: 'success'

        }));


    }
}
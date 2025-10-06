import { LightningElement,wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getObjectInfos } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACC_OBJ  from '@salesforce/schema/Account';
import OPP_OBJ  from '@salesforce/schema/Opportunity';
import INDUS_FIELD  from '@salesforce/schema/Account.Industry';
export default class GetObjectInfoDemo extends LightningElement {

    defaultrectypeId;
    objName;
    results;
    @wire(getObjectInfo, {objectApiName : ACC_OBJ})
    accObjDetails({data,error}){
        if(data){
            console.log(JSON.stringify(data));
            this.defaultrectypeId= data.defaultRecordTypeId;
            this.objName = data.apiName;
        }
        if(error){
            console.log(JSON.stringify(data));
        }
    }

    objApiName = [ACC_OBJ,OPP_OBJ];
    @wire(getObjectInfos, {objectApiNames : '$objApiName'})
    accconObjDetails({data,error}){
        if(data){
            console.log(JSON.stringify(data));
           this.results = data.results;
                }
        if(error){
            console.log(JSON.stringify(data));
        }
    }

    @wire(getPicklistValues,{recordTypeId : '$defaultrectypeId' ,fieldApiName :INDUS_FIELD })
    picklistValues({data,error}){
        if(data){
            console.log('picklist'+JSON.stringify(data));
                }
        if(error){
            console.log('picklist'+JSON.stringify(error));
        }

    }
}
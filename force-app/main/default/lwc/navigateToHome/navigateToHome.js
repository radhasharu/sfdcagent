import { LightningElement,wire } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import {encodeDefaultFieldValues} from 'lightning/pageReferenceUtils'
import {CurrentPageReference} from 'lightning/navigation'
export default class NavigateToHome extends NavigationMixin(LightningElement) {

    @wire(CurrentPageReference)
    pageRef

    get pageReference(){
        return this.pageRef ? JSON.stringify(this.pageRef,null,2 ) : '';
    }
    navigateToNewRecordDefault(event){
       const defaultValues = encodeDefaultFieldValues({
            FirstName :'Radha',
            LastName : 'G',
            LeadSource : 'Other'
        })
        this[NavigationMixin.Navigate]({
            type :'standard__objectPage',
            attributes:{
                objectApiName : 'Contact',
                actionName : 'new',
            },
            state:{
                defaultFieldValues : defaultValues
            }
        })

    }

    navigateToHome(event){
        this[NavigationMixin.Navigate]({
            type :'standard__namedPage',
            attributes:{
                pageName : 'home'
            }
        })

    }
    navigateToChatter(event){
        this[NavigationMixin.Navigate]({
            type :'standard__namedPage',
            attributes:{
                pageName : 'chatter'
            }
        })

    }

    navigateToNewRecord(event){
        this[NavigationMixin.Navigate]({
            type :'standard__objectPage',
            attributes:{
                objectApiName : 'Contact',
                actionName : 'new'
            }
        })

    }

    navigateToListView(event){
        this[NavigationMixin.Navigate]({
            type :'standard__objectPage',
            attributes:{
                objectApiName : 'Contact',
                actionName : 'list'
            },
            state :{
                filterName : 'Recent'
            }
        })

    }

    navigateToFiles(event){
        this[NavigationMixin.Navigate]({
            type :'standard__objectPage',
            attributes:{
                objectApiName : 'ContentDocument',
                actionName : 'home'
            }
        })
    }

    navigateToRecordView(event){
        this[NavigationMixin.Navigate]({
            type :'standard__recordPage',
            attributes:{
                recordId : '0032w00001JRYkvAAH',
                objectApiName : 'Contact',
                actionName : 'view'
            }
        })
    }
    navigateToRecordEdit(event){
        this[NavigationMixin.Navigate]({
            type :'standard__recordPage',
            attributes:{
                recordId : '0032w00001JRYkvAAH',
                objectApiName : 'Contact',
                actionName : 'edit'
            }
        })
    }

    navigateToTab(event){
        this[NavigationMixin.Navigate]({
            type :'standard__navItemPage',
            attributes:{
                apiName : 'LWC_Fundamentals_2'
            }
        })
    }

    navigateToRelatedPage(event){
        this[NavigationMixin.Navigate]({
            type :'standard__recordRelationshipPage',
            attributes:{
                recordId : '0012w00001z5kiwAAA',
                objectApiName : 'Account',
                relationshipApiName : 'Contacts',
                actionName :'view'
            }
        })
    }

    navigateToWebPage(event){
        this[NavigationMixin.Navigate]({
            type :'standard__webPage',
            attributes:{
                url : 'https://www.google.com'
            }
        })
    }

    navigateToLwcPage(event){
        var defination = {
            componentDef : 'c:helloWorld',
            attributes :{
                greeting : 'Worlds' 
            }
        }
        this[NavigationMixin.Navigate]({
            type :'standard__webPage',
            attributes:{
                url : '/one/one.app#'+btoa(JSON.stringify(defination))
            }
        })
    }

    navigateToAurComp(event){
        
        this[NavigationMixin.Navigate]({
            type :'standard__component',
            attributes:{
                componentName : 'c__HelloWorldAura'
            },
            state:{
                'c__id': '12345'
            }
        })
    }
    
    navigateToVFPage(event){
         this[NavigationMixin.Navigate]({
            type :'standard__webPage',
            attributes:{
                url : '/apex/HelloWorldVFPage'
            }
        }).then(generatedUrl =>{
            window.open(generatedUrl,'_blank')
        })
    }
    
}
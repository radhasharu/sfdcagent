({
    openModel: function(component, event, helper) {
     
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        
        component.set("v.isOpen", false);
        var homeEvent = $A.get("e.force:navigateToObjectHome");
        homeEvent.setParams({
            "scope": "Opportunity"
        });
        homeEvent.fire();
    },
    
    handleLoad: function(cmp, event, helper) {
        
        cmp.set('v.showSpinner', false);
    },
    
    handleSubmit: function(cmp, event, helper) {
        cmp.set('v.disabled', true);
        cmp.set('v.showSpinner', true);
    },
    handleError: function(cmp, event, helper) {
        // errors are handled by lightning:inputField and lightning:messages
        // so this just hides the spinner
        cmp.set('v.showSpinner', false);
    },
    
    handleSuccess: function(cmp, event, helper) {
        
        
        var param = event.getParams().response;
        
        //cmp.set('v.recordId', params.response.id);
        // var id=params.response.id;
        cmp.set('v.showSpinner', false);
        
        cmp.set('v.saved', true);
        cmp.set("v.isOpen", false);
        alert("Opportunity Saved Successfully " +param.id );
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."+param.id,
            "type" : "success"
        });
        
        toastEvent.fire();
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId":param.id
            //  "slideDevName": "detail"
        });
        
        navEvt.fire();
        
        
        
        
    },
    fetchList : function(component, event, helper) {
        helper.OppHelper(component, event, helper);
    }
    
    
})
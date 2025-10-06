({
    openModel: function(component, event, helper) {
        
         
        
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        
        component.set("v.isOpen", false);
    },
    
    displayMsg: function(component, event, helper) {
        component.set("v.showSpinner", true);
        component.set("v.isOpen", false);
        helper.getTextMsg(component);
        
    },
})
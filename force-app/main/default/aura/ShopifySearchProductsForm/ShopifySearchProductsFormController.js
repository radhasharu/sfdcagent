({
    getVendors : function(component,event,helper){
        console.log('Helper called');
        helper.getAllVendors(component,event,helper);
    },
    
     onFormSubmit : function(component, event, helper) {
        var productVendor = component.find("vendorSelect").get("v.value");
        var data = {
            "productVendor" : productVendor
            
        };
        console.log('data=='+data);
        var formsubmit = component.getEvent("formsubmit");
          console.log('formsubmit=='+formsubmit);
        formsubmit.setParams({
            "formData" : data
        });
        
        formsubmit.fire();
    }
    
    
})
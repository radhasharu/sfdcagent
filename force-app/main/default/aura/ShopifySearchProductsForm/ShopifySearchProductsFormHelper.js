({
    getAllVendors : function(component) {
        var action = component.get("c.getProductVendors");
        action.setParams({
            'objectName': component.get("v.ObjectName"),
            'field_apiname': component.get("v.Vendor"),
            'nullRequired': true
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            
            if (state === "SUCCESS"){
                console.log('response.getReturnValue()==='+response.getReturnValue());
                component.set("v.vendorList", response.getReturnValue());
            }
            else if (state === "ERROR"){
                console.log(response.getError());
            }
            else{
                console.log(response);
            }
        });
        $A.enqueueAction(action);
    }
    
    
})
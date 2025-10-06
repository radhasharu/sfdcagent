({
    callProdComp : function(component, event, helper) {
        var evt = $A.get("e.force:navigateToComponent");
        console.log('event entry'+evt);
        evt.setParams({
            componentDef: "c:ShopifyProductComponent",
            componentAttributes: {
                // Attributes here.
            }
        });
        evt.fire();
        
    },
    callCreateProdComp : function(component, event, helper) {
        var evt = $A.get("e.force:navigateToComponent");
        console.log('event entry'+evt);
        evt.setParams({
            componentDef: "c:ShopifyProductComponent",
            componentAttributes: {
                // Attributes here.
            }
        });
        evt.fire();
        
    }
})
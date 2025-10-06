({
	onSearch : function(component) {
        var action = component.get("c.getProducts");
        action.setParams({
            "productVendor" : component.get("v.productVendor")
        });

        action.setCallback(this, function(response) {
            var state = response.getState(); 
            
            if (state === "SUCCESS"){
                component.set("v.products", response.getReturnValue());
                console.log(response.getReturnValue());
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
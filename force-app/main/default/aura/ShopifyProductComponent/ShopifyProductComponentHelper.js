({
    getProductlist : function(component) {
        var action = component.get("c.viewAllProducts");
        console.log('action =='+ action);
        action.setCallback(this, function(actionResult) {
            component.set('v.products', actionResult.getReturnValue());
         });
          $A.enqueueAction(action);
    }
})
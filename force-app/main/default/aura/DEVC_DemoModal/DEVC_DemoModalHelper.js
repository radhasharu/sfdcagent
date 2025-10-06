({
	getTextMsg : function(component) {
		var action = component.get("c.getText");
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                component.set('v.textMsg', a.getReturnValue());
                alert(a.getReturnValue());
                setTimeout(function(){component.set("v.showSpinner",false);},2000);
            }
            
        });
        $A.enqueueAction(action);
       
	}
    
})
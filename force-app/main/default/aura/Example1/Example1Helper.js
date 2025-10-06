({
	gettotalCount : function(component, event, helper) {
        var action = component.get("c.getContactCount");
        action.setCallback(this, function(a){
            component.set("v.totalcontact", a.getReturnValue());
        });
        $A.enqueueAction(action);
		
	}
})
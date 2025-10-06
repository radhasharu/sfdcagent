({
    doInit : function(component, event, helper) {
		helper.gettotalCount(component, event, helper);
	},
	updatevalue : function(component, event, helper) {
        var val = component.find("a1").getElement().getvalue();
        component.set("v.greetings",val);
		
	}
    
   
})
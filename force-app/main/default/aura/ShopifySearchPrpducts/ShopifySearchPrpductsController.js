({
	initSearch : function(component, event, helper) {
		helper.onSearch(component);
	},
    
    doSearch : function(component, event, helper) {
        var params = event.getParam('arguments');
        
        component.set("v.productVendor", params.productVendor);
		helper.onSearch(component);
	}
})
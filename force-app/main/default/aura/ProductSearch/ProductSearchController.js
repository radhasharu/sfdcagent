({
	onFormSubmit : function(component, event, helper) {
        console.log("Entry");
		var data = event.getParam("formData");
        console.log("Entrydata" + data);
        var ShopifySearchProducts = component.find("ShopifySearchProductsCmp");
        if (ShopifySearchProducts) {
            ShopifySearchProducts.search(data.productVendor);
        }
	}
    
})
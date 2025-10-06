public class ShopExcitingControllerClass {
    
    @AuraEnabled
    public static List<String> getProductVendors(String objectName, String field_apiname,Boolean nullRequired){
        List<String> optionlist = new List<String>();       
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get(objectName.toLowerCase()).getDescribe().fields.getMap();        
        List<Schema.PicklistEntry> picklistValues = field_map.get(field_apiname).getDescribe().getPickListValues();       
        if(nullRequired == true){
            optionlist.add('--None--');
        }       
        for (Schema.PicklistEntry pv : picklistValues) {
            optionlist.add(pv.getValue());
        }
        return optionlist;
    }
    @AuraEnabled
    public static List<Product2> viewAllProducts(){  
        List<Product2> products= new List<Product2>([select Id,Product_Id__c,Name,Product_Description__c,Vendor__c,
                                                     Product_Type__c,Product_Image__c,format(size__c),Price__c from Product2 where
                                                     Product_Id__c != NULL]);
        System.debug('Result= ='+products);
        return products;
        
    }
    
    @AuraEnabled
    public static List<Product2> getProducts(String productVendor){
        List<Product2> products = new List<Product2>();
        if(productVendor == null || productVendor == ''){
            system.debug('entryif');
            products = [select Id,Product_Id__c,Name,Product_Description__c,Vendor__c,
                        Product_Type__c,Product_Image__c,format(size__c),Price__c from Product2 where
                        Product_Id__c != NULL];
        }
        else{
            system.debug('entryifelse');
            products = [select Id,Product_Id__c,Name,Product_Description__c,Vendor__c,
                        Product_Type__c,Product_Image__c,format(size__c),Price__c from Product2 where
                        Product_Id__c != NULL and Vendor__c = :productVendor];
        }
        
        return products;
    }
    
    
}
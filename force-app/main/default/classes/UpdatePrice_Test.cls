@isTest
private class UpdatePrice_Test {

    @isTest static void insertPrice(){
        Product__c prod = new Product__c(Name='Jeans',Category__c='Fashion');
        UpdatePriceTriggerClass.insertPrice(prod);
    }
    
    @isTest static void updatePrice(){
        Product__c prod = new Product__c(Name='Jeans',Category__c='Fashion',Product_Price__c=100);
        UpdatePriceTriggerClass.updateFee(prod,prod.Product_Price__c);
    }
}
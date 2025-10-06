trigger UpdatePriceTrigger on Product__c (before insert,before update) {
    
    if(Trigger.isInsert){
        for(Product__c prod : Trigger.new){
            UpdatePriceTriggerClass.insertPrice(prod);
        }
    }
    
    if(Trigger.isUpdate){
        for(Product__c prod : Trigger.new){
            UpdatePriceTriggerClass.updateFee(prod,Trigger.oldmap.get(prod.Id).Product_Price__c);
        }
    }
    
}
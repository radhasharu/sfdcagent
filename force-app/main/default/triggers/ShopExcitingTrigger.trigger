trigger ShopExcitingTrigger on Product2 (after insert,after delete) {
    
    if(trigger.isafter && trigger.isinsert){
        String jsonString = json.serialize(Trigger.NEW);
        ShopExcitingAsyncClass.addProduct(jsonString);
    }
    
    if(trigger.isafter && trigger.isdelete){
        String jsonString = json.serialize(Trigger.OLD);
        ShopExcitingAsyncClass.deleteProduct(jsonString);
    }
    
    
    
}
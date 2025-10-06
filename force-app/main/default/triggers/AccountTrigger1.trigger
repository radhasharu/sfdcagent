trigger AccountTrigger1 on Account (after insert,after update) {
    
    for(Account acc : Trigger.new){
        acc.Industry = 'Education';
        update acc;
    }
    
   /* if(Trigger.isBefore){
        if(Trigger.isInsert){
            //when account is inserted, set account industry as Education - before Insert
            //Trigger -- List<Sobject> - List<ACCount>
           AccountTriggerHandler.setIndustry(Trigger.new);
           AccountTriggerHandler.checkType(Trigger.new);
          
            
        }
        if(Trigger.isUpdate){
             //When account Annual revence is updated = 10000 , set industry to Agriculture - before update
             //Trigger old
            system.debug('before old==>'+Trigger.old);
            system.debug('before new==>'+Trigger.new);
             AccountTriggerHandler.updateIndustry(Trigger.new,Trigger.oldMap);
            
        }
        
        
    }
    //Create related Contact record whenever a new Account record is Created
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            system.debug('after old -->'+Trigger.old);
            system.debug('after new -->'+Trigger.new);
            AccountTriggerHandler.createContact(Trigger.new);
        }
        
    }*/
    
    
}
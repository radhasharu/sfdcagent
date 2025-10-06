trigger UpdateOppLineItem on Opportunity (after insert) {
    system.debug(trigger.new);
    
    if(Trigger.isInsert)
    {
        for(Opportunity opp : trigger.new){
            
            UpdateOppLineItemClass.afterInsert(opp.Location_Preferred__c,opp.Id,opp.How_many_people_you_need_to_accommodate__c);
        }
    }
    
    
}
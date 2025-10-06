trigger LeadConversionTrigger on Lead (after insert, after update) {
    
    List<lead> leadList = trigger.new;
    Set<ID> leadIds= new Set<ID>();
    for(lead leadRecord : leadList) {
        if (leadRecord.Status == 'Closed - Converted' && leadRecord.isConverted == false){
              
             leadIds.add(leadRecord.Id);
        }
    }
    //system.debug('size'+ leadIds.size());
    if(leadIds.size()  > 0){
              ConvertLeads.LeadAssign(leadIds);
    }

}
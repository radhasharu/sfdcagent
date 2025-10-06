trigger testTrigger on Opportunity (before update) {
   
   
    for(Opportunity opp : Trigger.new){
	        
       if(opp.StageName == 'Closed Won' && trigger.oldMap.get(opp.id).StageName != 'Closed Won')
           
        opp.Status_Changed__c = true;
        }


}
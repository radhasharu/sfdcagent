trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {
    // Create a list to store opportunities that need processing
    List<Opportunity> opportunitiesToProcess = new List<Opportunity>();
    
    // Loop through the trigger context to add relevant opportunities
    for (Opportunity opp : Trigger.new) {
        // We check that the Opportunity is either being inserted or updated to "Closed Won"
        if ((Trigger.isInsert || Trigger.isUpdate) && opp.StageName == 'Closed Won') {
            opportunitiesToProcess.add(opp);
        }
    }
    
    // After identifying the opportunities to process, call the OpportunityHandler
    if (!opportunitiesToProcess.isEmpty()) {
        // Loop through the list and process each opportunity
        for (Opportunity opp : opportunitiesToProcess) {
            // Call the handleClosedOpportunity method to process each opportunity
            OpportunityHandler.handleClosedOpportunity(opp);
        }
    }
}
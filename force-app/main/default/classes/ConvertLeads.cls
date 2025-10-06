public class ConvertLeads
{
    public static void LeadAssign(Set<Id> LeadIds)
    {
        LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus 
                                 WHERE  IsConverted=true Limit 1];
        List<Database.LeadConvert> MassLeadconvert = new List<Database.LeadConvert>();
        List<Lead> leadlist = new List<Lead>();
         Map<Id,String> leadmap = new Map<Id,String>();
        leadlist = [SELECT Id,Name from Lead where Id in :LeadIds];
        for(Lead l : leadlist){
            leadmap.put(l.Id,l.Name);
        }
        
        for(id currentlead : LeadIds){
            
            Database.LeadConvert Leadconvert = new Database.LeadConvert();
            Leadconvert.setLeadId ( currentlead );                
            Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
           // Leadconvert.setDoNotCreateOpportunity(TRUE); 
            Leadconvert.setOpportunityName('Opportunity'+leadmap.get(currentlead));
            //you can remove this line if you want to create an opportunity during  conversion 
            MassLeadconvert.add(Leadconvert);
        }
        
        if (!MassLeadconvert.isEmpty()) {
            List<Database.LeadConvertResult> lcr = Database.convertLead(MassLeadconvert);
            //Select Id,ConvertedAccountId from Lead where Id = '00Q2w00000B6pvcEAB'
        }
    }
}
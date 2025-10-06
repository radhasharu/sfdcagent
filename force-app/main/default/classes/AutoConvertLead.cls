public class AutoConvertLead {
    @InvocableMethod
    public static void LeadAssign(List<Id> LeadIds)
    {
        Database.LeadConvert Leadconvert = new Database.LeadConvert();
        Leadconvert.setLeadId(LeadIds[0]);
        Id leadId = Leadconvert.getLeadID();
        Lead lead = [SELECT name FROM Lead where Id=:leadId];
        LeadStatus Leads= [SELECT Id,MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Leadconvert.setConvertedStatus(Leads.MasterLabel);
        Leadconvert.setOpportunityName('Oakside Realty Opportunity for '+lead.name); 
        Database.LeadConvertResult Leadconverts = Database.convertLead(Leadconvert);
        System.assert(Leadconverts.isSuccess());
    }
}
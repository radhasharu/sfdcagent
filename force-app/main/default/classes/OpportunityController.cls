public class OpportunityController {

     @AuraEnabled
    public static List <Opportunity> fetchOpp() {
       
        List<Opportunity> oppList = [SELECT  Name,Account.Name,StageName, 
                                    Amount, CloseDate,CreatedDate  from Opportunity ORDER BY CreatedDate DESC LIMIT 10];
        
        return oppList;
    }
}
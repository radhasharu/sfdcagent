@isTest
public class OpportunityHandler_Test {
    
    @isTest
    public static void handleOppTest(){
        Opportunity opp = new Opportunity(Name = 'Test OPP');
        opp.StageName = 'Closed Won';
        opp.CloseDate = System.today();
        insert opp ;
        Test.startTest();
        OpportunityHandler.handleClosedOpportunity(opp);
        Test.stopTest();
    }

}
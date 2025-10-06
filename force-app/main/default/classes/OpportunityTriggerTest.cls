@isTest
public class OpportunityTriggerTest {
    
    @testSetup
    public static void testData(){
        Opportunity opp = TestDataFactoryClass.createOpportunity();
    }
    
    @isTest
    public static void updateOpportunity(){
        Opportunity opp =[Select Id,StageName from Opportunity LIMIT 1];
        Test.startTest();
        opp.StageName = 'Closed Won';
        opp.CloseDate = System.today();
        update opp;
        Test.stopTest();
        
    }

}
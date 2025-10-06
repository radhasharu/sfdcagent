@isTest
public class TestDataFactoryClass {
    
    public static Account createAccount(){
        Account acc = new Account(Name = 'Samsung');
        acc.AnnualRevenue = 1000002;
        insert acc;
        return acc;
    }
    
    public static Opportunity createOpportunity(){
        Account acc = new Account(Name = 'Samsung');
        insert acc;
        Opportunity opp = new Opportunity(Name = 'Opp1',AccountId = acc.Id,StageNAme = 'Prospecting',CloseDate = System.today());
        insert opp;
        return opp;
    }
    
    public static void createAccountBulk(Integer numOfAcc){
        List<Account> accListtoInsert = new List<Account>();
        for(Integer i = 0;i<numOfAcc ;i++){
            String Name = 'Test Account '+ i;
            accListtoInsert.add(new Account(Name = 'Test Account'));
        }
        insert accListtoInsert;
    }

}
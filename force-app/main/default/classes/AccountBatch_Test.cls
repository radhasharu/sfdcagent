@isTest
public class AccountBatch_Test {
    
    @testSetup
    public static void testData(){
        TestDataFactoryClass.createAccountBulk(200);
    }
    
    @isTest
    public static void updateAccountBatch(){
        Test.startTest();
        AccountBatch accBatch = new AccountBatch();
        Database.executeBatch(accBatch);
        Test.stopTest();
        List<Account> accList = [Select Id,Industry from Account];
        for(Account acc: accList){
            System.assertEquals('Agriculture',acc.Industry);
        }
    }

}
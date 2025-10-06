@isTest
public class AccountProcessor_Test {

     @testSetup
    public static void testData(){
        Account acc = TestDataFactoryClass.createAccount();
    }
    
    @isTest
    public static void processAccountTest(){
        Account acc = [Select Id from Account where Name = 'Samsung'];
        Test.startTest();
        AccountProcessor.processAccount(acc.ID);
        Test.stopTest();
    }
    
     @isTest
    public static void processAccountTest2(){
        Account acc = [Select Id,AnnualRevenue from Account where Name = 'Samsung'];
        acc.AnnualRevenue = 10;
        update acc;
        Test.startTest();
        AccountProcessor.processAccount(acc.ID);
        Test.stopTest();
    }
    
    
     @isTest
    public static void processAccountTest3(){
        Test.startTest();
        AccountProcessor.calculateDiscount(120);
        Test.stopTest();
    }
    
   
    
}
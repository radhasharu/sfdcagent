@isTest(seeAllData = false)
public class AccountManager_Test1 {
    
    @isTest
    private static void createAccountAndContact_pos(){
        String accountName = 'Apple';
        String contactName = 'John';
        Test.startTest();
        AccountManager.createAccountAndContact(accountName,contactName);
        Test.stopTest();
        Account acc = [Select Id,Name from Account where Name = 'Apple'];
        Contact con = [Select Id,Name from Contact where Name = 'John']; 
        System.assertEquals('Apple',acc.Name,'Account created successfully');
        System.assertEquals('John',con.Name,'Contact created successfully');
       
    }
    
    @isTest
    private static void createAccountAndContact_neg(){
        try{
            Test.startTest();
            AccountManager.createAccountAndContact(null,'John');
            Test.stopTest();
        }
        catch(Exception e){
            System.assertEquals('Account Name and Contact Name are required.',e.getMessage());
        }
    }

}
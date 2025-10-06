@isTest(seeAllData = false)
public class AccountManager_Test {
    
    @testSetup
    public static void testData(){
        Account acc = new Account(Name = 'Samsung');
        insert acc;
        Contact con = new Contact(LastName = 'David', AccountId = acc.Id);
        insert con;
    }
    
    @isTest
    public static void createAccountAndContact_postest(){
        String accountName = 'Apple';
        String contactName = 'John';
        Test.startTest();
        AccountManager.createAccountAndContact(accountName,contactName);
        Test.stopTest();
        Account acc = [Select ID,NAme from Account where Name = 'Apple'];
        System.assertEquals('Apple',acc.Name,'Acount created successfully'); //expected,actual,msg
        Contact con = [Select ID,LAstNAme from Contact where LAstNAme = 'John'];
        System.assertEquals('John',con.LAstNAme,'Contact created successfully');
    }
    
    
     @isTest
    public static void createAccountAndContact_negtest(){
        try{
            Test.startTest();
            AccountManager.createAccountAndContact(null,'John');
            Test.stopTest();
        }
        catch(Exception e){
            System.debug(e.getMessage());
            System.debug(e.getLineNumber());
            System.assertEquals('Account Name and Contact Name are required.',e.getMessage());
        }
    }

    @isTest
    public static void updateAccount_postest(){
        Account acc = [Select Id from Account where Name = 'Samsung'];
        Test.startTest();
        AccountManager.updateAccountName(acc.Id, 'Sam');
        Test.stopTest();
        Account updateAcc = [Select Id,NAme from Account where Name = 'Sam'];
        System.assertEquals('Sam',updateAcc.Name,'Account updated successfully');
        
    }
    
    @isTest
    public static void deletecontact_posTest(){
        Contact con = [Select Id from Contact where Name = 'David'];
        Test.startTest();
        AccountManager.deleteContact(con.Id);
        Test.stopTest();
    }

}
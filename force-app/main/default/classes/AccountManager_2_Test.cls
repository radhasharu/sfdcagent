@isTest
public class AccountManager_2_Test {
    
    @testSetup
    public static void testData(){
        Account acc = TestDataFactoryClass.createAccount();
    }
    
    @isTest
    public static void updateAccountStatus_test(){
        Account acc = [Select Id from Account LIMIT 1];
        Test.startTest();
        AccountManager_2.updateAccountStatus(acc.Id,'Agriculture');
        Test.stopTest();
        Account updatedacc = [Select Id,Industry from Account LIMIT 1];
        System.assertEquals('Agriculture',updatedacc.Industry);
    }
    
    @isTest
    public static void updateAccountStatus_test2(){
        try{
            User u = [Select Id,Name from USer where Profile.Name = 'Sales Person contacts Lead' and isActive = true];
            System.debug('User'+u);
            Account acc = [Select Id from Account LIMIT 1];
            System.runAs(u){
                Test.startTest();
                AccountManager_2.updateAccountStatus(acc.Id,'Agriculture');
                Test.stopTest();
            }
        }
        catch(Exception e){
            System.assertEquals('User does not have sufficient permissions to update this Account.',e.getMessage());
        }
        
    }
    
    
        
        
    }
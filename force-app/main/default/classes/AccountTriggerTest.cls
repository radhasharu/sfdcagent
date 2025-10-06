@isTest(seeAllData = false)
public class AccountTriggerTest {
    
    
    @isTest
    public static void insertAccountTest(){
        Account acc = new Account(name = 'Account 1',type = 'Channel Partner / Reseller');
        insert acc;
        Account acc1 =[Select Id,Name,Industry from account where id = :acc.Id];
        System.debug(acc1);
        System.assertEquals('Education',acc1.Industry);
    }
    
     @isTest
    public static void insertAccountTest2(){
        try{
            Account acc = new Account(name = 'Account 1');
            insert acc;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
    
    @isTest
    public static void updateAccountTest(){
        Account acc = new Account(name = 'Account 1',type = 'Channel Partner / Reseller');
        insert acc;
        acc.AnnualRevenue = 10000;
        update acc;
    }

}
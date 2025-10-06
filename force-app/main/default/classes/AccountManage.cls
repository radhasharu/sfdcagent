public class AccountManage {
    
    public static void methodName1(){
        try{
            Account acc1 = new Account(Name = 'AccountRadha2');
            insert acc1;
            Contact con1 = new Contact(LastName = 'Gangaraju2', FirstName = 'Radha2',AccountId = acc1.Id);
            insert con1;
        }
        catch(Exception e){
            System.debug('Exception'+e.getMessage());
        }
    }
    
}
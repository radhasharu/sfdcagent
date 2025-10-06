public class AccountInsert {
    
    public static void insertAcccount(){
        
        List<Account> accList = new List<Account>();
        Account acc = new Account(Name = 'Account1aa');
        accList.add(acc);
        Account acc1 = new Account(Name = 'Account2bb');
        accList.add(acc1);
        accList.add(new Account(Name = 'Account3cc'));
        accList.add(new Account(Name = 'Account4dd'));
        accList.add(new Account());
       // insert accList;
        Database.SaveResult[] srList = database.insert(accList,false);
        
        for(Database.SaveResult sr: srList){
            if(sr.isSuccess()) {
                System.debug('Successfully inserted Accounts : ' + sr.getId());
            } else {
                // iterate over the failed ones
                for(Database.Error error : sr.getErrors()) {
                    System.debug('Error Status : ' + error.getStatusCode() + ' : ' + 'Error Fields : ' + error.getFields() + error.getMessage());
                    //insert this error message to custom object
                }
            }
        }
        
        
    }
    
    public static void insertAcccountnormal(){
        try{
            List<Account> accList = new List<Account>();
            Account acc = new Account(Name = 'Account1aa');
            accList.add(acc);
            Account acc1 = new Account(Name = 'Account2bb');
            accList.add(acc1);
            accList.add(new Account(Name = 'Account3cc'));
            accList.add(new Account(Name = 'Account4dd'));
            accList.add(new Account());
            insert accList;
        }
        catch(Exception e){
             System.debug('Excpetion is'+e.getMessage());
            //insert this error message to custom object
        }
        
        
        
    }
    
}
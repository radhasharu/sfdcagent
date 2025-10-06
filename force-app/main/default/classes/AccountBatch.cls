global class AccountBatch implements Database.Batchable<sObject>,Schedulable {
   global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id,Name,Industry FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList) {
     
        System.debug(accList);
        for(Account acc : accList)
        {        
            acc.Industry = 'Agriculture';
        }
        try {
            update accList;
        
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    global void finish(Database.BatchableContext BC) {
     
    }
    global void execute(SchedulableContext SC) {
        Database.executeBatch(new AccountBatch(),2);
    }
    public static void runApex(){
        
    }
}
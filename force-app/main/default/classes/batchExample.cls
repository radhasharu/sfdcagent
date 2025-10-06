global class batchExample implements Database.Batchable<sObject> {
   global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id,Name,Site FROM Account LIMIT 1';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList) {
     
        System.debug(accList);
        for(Account acc : accList)
        {        
            acc.Site = 'vfislkgroupbatch2.com';
        }
        try {
            update accList;
        
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    global void finish(Database.BatchableContext BC) {
        
        Database.executeBatch(new batchExample());
        
        /*AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email    from AsyncApexJob where Id =:BC.getJobId()];
      	System.debug(a);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Match Merge Batch ' + a.Status);
        mail.setPlainTextBody('records processed ' + a.TotalJobItems +   ' with '+ a.NumberOfErrors + ' failures.'+a.JobItemsProcessed +'===' + a.Status);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
  }
}
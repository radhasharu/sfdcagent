trigger ContactTrigger on Contact (before insert) {
 for (Contact con : Trigger.new) {
        // Let's assume we update a related contact field when the account is updated
        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :con.AccountId LIMIT 1];
        acc.Industry = 'Education';
        update acc;  // This will cause the trigger to fire again for Account
    }
}
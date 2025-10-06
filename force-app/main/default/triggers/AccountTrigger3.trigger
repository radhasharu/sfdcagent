trigger AccountTrigger3 on Account (after update) {
    for (Account acc : Trigger.new) {
        // Let's assume we update a related contact field when the account is updated
        Contact c = [SELECT Id, AccountId FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
        c.Title = 'Updated due to Account change';
        update c;  // This will cause the trigger to fire again for Account
    }
}
public class AccountManager_3 {

    // Method that inserts multiple accounts and queries
    public static void insertAndQueryAccounts(Integer numberOfAccounts) {
        List<Account> accountsToInsert = new List<Account>();

        // Create multiple Account records
        for (Integer i = 0; i < numberOfAccounts; i++) {
            accountsToInsert.add(new Account(Name = 'Test Account ' + i));
        }
        insert accountsToInsert;  // DML operation

        // Query all the inserted Accounts
        List<Account> accountsFromDb = [SELECT Id, Name FROM Account LIMIT 100];  // SOQL query

        System.debug('Number of Accounts inserted: ' + accountsToInsert.size()); //10
        System.debug('Number of Accounts fetched: ' + accountsFromDb.size()); //15
    }
}
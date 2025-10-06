@isTest
public class AccountManager_3Test {

    @isTest
    static void testInsertAndQueryAccounts() {
        // Setup: Insert a few initial records, which will count towards the governor limits
        List<Account> setupAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            setupAccounts.add(new Account(Name = 'Setup Account ' + i));
        }
        insert setupAccounts;

        // Verify initial governor limits
        Integer initialQueryCount = Limits.getQueries(); //0
        Integer initialDmlCount = Limits.getDmlStatements(); //1

        // Start test context to reset governor limits
        Test.startTest();

         // Verify the governor limits within the test context
        Integer startTestQueryCount = Limits.getQueries(); //0
        Integer startTestDMLCount = Limits.getDmlStatements(); //0
        // Now test the actual method under isolated conditions
        AccountManager_3.insertAndQueryAccounts(10);
         // Verify the governor limits within the test context
        Integer stopTestQueryCount = Limits.getQueries(); //1
        Integer stopTestDMLCount = Limits.getDmlStatements(); //1

        // Stop test context
        Test.stopTest();
        
         // Verify the governor limits within the test context
        Integer finalQueryCount = Limits.getQueries(); //0
        Integer finalDmlCount = Limits.getDmlStatements(); //1

       

        // Ensure the limits inside the test block were counted correctly
        System.debug('Initial Query Count: ' + initialQueryCount);
        System.debug('StartTest Query Count: ' + startTestQueryCount);
        System.debug('StopTest Query Count: ' + stopTestQueryCount);
        System.debug('Final Query Count: ' + finalQueryCount);
        System.debug('Initial DML Count: ' + initialDmlCount);
        System.debug('StartTest DML Count: ' + startTestDMLCount);
        System.debug('StopTest DML Count: ' + stopTestDMLCount);
        System.debug('Final DML Count: ' + finalDmlCount);
        
    }
}
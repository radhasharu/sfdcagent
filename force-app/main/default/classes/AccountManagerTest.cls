@isTest
public class AccountManagerTest {

    // Using @testSetup to create reusable test data
    @testSetup
    static void setupData() {
        // Create an Account and a Contact for testing
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test Contact',LastName ='Contact1', AccountId = testAccount.Id);
        insert testContact;
    }

    // Positive Scenario: Test account and contact creation
    @isTest
    static void testCreateAccountAndContact() {
        // Fetch the Account and Contact inserted by @testSetup
        Account setupAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        Contact setupContact = [SELECT Id, FirstName FROM Contact WHERE AccountId = :setupAccount.Id LIMIT 1];

        // Verify that the Account and Contact are correctly created
        System.assertNotEquals(null, setupAccount, 'Account should be created.');
        System.assertEquals('Test Account', setupAccount.Name, 'Account name should match.');

        System.assertNotEquals(null, setupContact, 'Contact should be created.');
        System.assertEquals('Test Contact', setupContact.FirstName, 'Contact first name should match.');
    }

    // Negative Scenario: Test missing account or contact name
    @isTest
    static void testCreateAccountAndContactWithMissingNames() {
        try {
            // Attempt to create an Account and Contact with missing names
            Test.startTest();
            AccountManager.createAccountAndContact('', 'Test Contact');
            Test.stopTest();
            System.assert(false, 'Exception should have been thrown due to missing account name.');
        } catch (AccountManager.AccountManagerException e) {
            System.assertEquals('Account Name and Contact Name are required.', e.getMessage());
        }

        try {
            Test.startTest();
            AccountManager.createAccountAndContact('Test Account', '');
            Test.stopTest();
            System.assert(false, 'Exception should have been thrown due to missing contact name.');
        } catch (AccountManager.AccountManagerException e) {
            System.assertEquals('Account Name and Contact Name are required.', e.getMessage());
        }
    }

    // Exception Scenario: Test invalid contact deletion (null ID)
    @isTest
    static void testDeleteContactWithNullId() {
        try {
            // Attempt to delete a contact with null Id
            Test.startTest();
            AccountManager.deleteContact(null);
            Test.stopTest();
            System.assert(false, 'Exception should have been thrown due to null contact ID.');
        } catch (AccountManager.AccountManagerException e) {
            System.assertEquals('Contact ID cannot be null.', e.getMessage());
        }
    }

    // Positive Scenario: Test updating account name
    @isTest
    static void testUpdateAccountName() {
        Account testAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        // Update the account name
        Test.startTest();
        Account updatedAccount = AccountManager.updateAccountName(testAccount.Id, 'Updated Account');
        Test.stopTest();

        // Verify that the account name was updated
        System.assertEquals('Updated Account', updatedAccount.Name, 'Account name should be updated.');
    }

    // Negative Scenario: Test updating account with empty name
    @isTest
    static void testUpdateAccountNameWithEmptyName() {
        Account testAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];

        try {
            // Attempt to update the account with an empty name
            Test.startTest();
            AccountManager.updateAccountName(testAccount.Id, '');
            Test.stopTest();
            System.assert(false, 'Exception should have been thrown due to empty account name.');
        } catch (AccountManager.AccountManagerException e) {
            System.assertEquals('New Account Name cannot be blank.', e.getMessage());
        }
    }
}

/* Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User adminUser = new User(
            Alias = 'adminuser',
            Email = 'adminuser@test.com',
            Username = 'adminuser@test.com',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert adminUser;*/
public class AccountManager {

    // Method to create an account and a contact
    public static Account createAccountAndContact(String accountName, String contactName) {
        if (String.isBlank(accountName) || String.isBlank(contactName)) {
            throw new AccountManagerException('Account Name and Contact Name are required.');
        }

        Account newAccount = new Account(Name = accountName);
        insert newAccount;

        Contact newContact = new Contact(LastName = contactName, AccountId = newAccount.Id);
        insert newContact;

        return newAccount;
    }

    // Method to update an account's name
    public static Account updateAccountName(Id accountId, String newName) {
        if (String.isBlank(newName)) {
            throw new AccountManagerException('New Account Name cannot be blank.');
        }

        Account account = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
        account.Name = newName;

        update account;

        return account;
    }

    // Method to delete a contact
    public static void deleteContact(Id contactId) {
        if (contactId == null) {
            throw new AccountManagerException('Contact ID cannot be null.');
        }

        Contact contact = [SELECT Id FROM Contact WHERE Id = :contactId LIMIT 1];
        delete contact;
    }
   
    // Custom exception for the class
    public class AccountManagerException extends Exception {}
}
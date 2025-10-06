public class AccountManager_2 {
    // Method to update account status based on user profile
    public static void updateAccountStatus(Id accountId, String industry) {
        // Get the current user's profile name
        String userProfileId = UserInfo.getProfileId();
        // Query the Profile object to get the profile name
        Profile p = [SELECT Name FROM Profile WHERE Id = :userProfileId LIMIT 1];
        String userProfileName = p.Name;
        
        // Query the Account record
        Account acc = [SELECT Id, Industry FROM Account WHERE Id = :accountId LIMIT 1];
        
        // Check if the user is a System Administrator
        if (userProfileName == 'System Administrator') {
            // If user is an admin, update the Account's industry
            acc.Industry = industry;
            update acc;
        } else {
            // If user is not an admin, throw an exception
            throw new AuthorizationException('User does not have sufficient permissions to update this Account.');
        }
    }
    
    // Custom exception for the class
    public class AuthorizationException extends Exception {}
}
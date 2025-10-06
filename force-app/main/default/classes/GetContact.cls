public with sharing class GetContact {
   
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        try {
            List<Contact> contList = [Select Id,FirstName,LastName from Contact LIMIT 5];
            return contList;
            
        } catch (Exception e) {
            system.debug('Exception =='+e.getMessage());
            return null;
        }
    }
}
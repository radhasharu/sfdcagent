public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String recordId) {
        
        if(String.isEmpty(recordId) || recordId == 'null')
            return [
                SELECT FirstName,LastName,Email
                FROM Contact LIMIT 5
            ];
        
        else {
            return [
                SELECT FirstName,LastName,Email
                FROM Contact where Id = :recordId LIMIT 5
            ];
        }
        
    }
}
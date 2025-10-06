public class ContactServer {
    
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContacts(){
        List<Contact> contactList = [Select Id,Name from Contact  ];
        return contactList;
    }

}
@isTest
public class UserAndContactTest {
    public testmethod static void testUserAndContact() {
       Test.startTest();
        InsertFutureUser.insertUser();
        Test.stopTest();
        Contact currentContact = new Contact(
            firstName = String.valueOf(System.currentTimeMillis()),
            lastName = 'Contact');
        insert(currentContact);
        
        User u =[Select Id from User where userName = 'futureuser9986@test.org1' LIMIT 1];
        System.debug('User'+u);
        
    }
      public testmethod static void testUserAndContact2() {
        InsertFutureUser.insertUser2();
        Contact currentContact = new Contact(
            firstName = String.valueOf(System.currentTimeMillis()),
            lastName = 'Contact');
        insert(currentContact);
    }
}
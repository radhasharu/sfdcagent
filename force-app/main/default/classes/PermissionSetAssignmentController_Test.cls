@isTest
public class PermissionSetAssignmentController_Test {
    
    @testSetup
    static void testSetup(){
        Id p = [select id from profile where name='System Administrator'].id;
        User userData = new User(FirstName='UserAdmin', LastName='UserAdminLastName', Alias='UserAli', IsActive=True, Email='UserAlias@exceptionHandle.com',
                                 ProfileId=p, Username='UserAlias'+ DateTime.now().getTime()+'@exceptionHandle.com', EmailEncodingKey='UTF-8',
                                 LanguageLocaleKey='en_US', LocaleSidKey='en_US', TimeZoneSidKey='GMT' );   
        insert userData;
        
        PermissionSet ps = new PermissionSet(Name = 'TestPermissionSet',Label = 'TestPermissionSet');
        insert ps;
    }
    
    @isTest 
    public static void getUsersTest1(){
        Test.startTest();
        PermissionSetAssignmentController.getUsers('UserAdmin','Name');
        Test.stopTest();
    }
    @isTest 
    public static void getUsersTest2(){
        Test.startTest();
        PermissionSetAssignmentController.getUsers('abc','Name');
        Test.stopTest();
    }
    @isTest 
    public static void getUsersTest3(){
        User u = [Select Id from User where LastName = 'UserAdminLastName' LIMIT 1];
        String userId = u.Id;
        Test.startTest();
        PermissionSetAssignmentController.getUsers(userId,'Id');
        Test.stopTest();
    }
    
    @isTest 
    public static void getPSTest1(){
        Test.startTest();
        PermissionSetAssignmentController.getPS('TestPermissionSet','Name');
        Test.stopTest();
    }
    @isTest 
    public static void getPSTest2(){
        Test.startTest();
        PermissionSetAssignmentController.getPS('abc','Name');
        Test.stopTest();
    }
    @isTest 
    public static void getPSTest3(){
        PermissionSet ps = [Select Id from PermissionSet where Name = 'TestPermissionSet'];
        String psId = ps.Id;
        Test.startTest();
        PermissionSetAssignmentController.getPS(psId,'Id');
        Test.stopTest();
    }
    @isTest 
    public static void assignPSTest1(){
        List<String> selectedUsers = new List<String>();
        List<String> selectedPS = new List<String>();
        PermissionSet ps = [Select Id from PermissionSet where Name = 'TestPermissionSet'];
        User u = [Select Id from User where LastName = 'UserAdminLastName' LIMIT 1];
        selectedUsers.add(u.Id);
        selectedUsers.add(u.Id);
        selectedPS.add(ps.Id);
        selectedPS.add(ps.Id);
        Test.startTest();
        PermissionSetAssignmentController.assignPS(selectedUsers,selectedPS);
        Test.stopTest();
    }
    
    @isTest 
    public static void assignPSTest2(){
        List<String> selectedUsers = new List<String>();
        List<String> selectedPS = new List<String>();
        PermissionSet ps = [Select Id from PermissionSet where Name = 'TestPermissionSet'];
        User u = [Select Id from User where LastName = 'UserAdminLastName' LIMIT 1];
        selectedUsers.add(u.Id);
        selectedPS.add(ps.Id);
        Test.startTest();
        PermissionSetAssignmentController.assignPS(selectedUsers,selectedPS);
        Test.stopTest();
    }
   
    
}
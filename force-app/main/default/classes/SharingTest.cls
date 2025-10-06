@isTest(SeeAllData = true)
public class SharingTest {
    
    
    @istest
    static void callomittedsharingmethod(){
        User u = [Select Id from User where Name = 'Bindu Pagad'];
        System.runAs(u){
            List<Flower__c> empList = OmittedSharing.getEmployeesfromWithsharing();
            System.debug('OmittedSharing with Size ==>'+empList.size()); //3
            
        }
    }
     @istest
    static void callomittedsharingmethod2(){
        User u = [Select Id from User where Name = 'Bindu Pagad'];
        System.runAs(u){
            List<Flower__c> empList = OmittedSharing.getEmployeesfromWithoutsharing();
            System.debug('OmittedSharing  without Size ==>'+empList.size()); //5
            
        }
    }
      @istest
    static void callomittedsharingmethod3(){
        User u = [Select Id from User where Name = 'Bindu Pagad'];
        System.runAs(u){
            List<Flower__c> empList = OmittedSharing.getEmployeesfromInheritedsharing();
            System.debug('OmittedSharing inher Size ==>'+empList.size()); //5
            
        }
    }
    
     @istest
    static void callomittedsharingmethod4(){
        User u = [Select Id from User where Name = 'Bindu Pagad'];
        System.runAs(u){
            List<Flower__c> empList = WithSharingClass.outerMethod();
            System.debug('OmittedSharing inher Size2 ==>'+empList.size()); 
            
        }
    }
    
    
}
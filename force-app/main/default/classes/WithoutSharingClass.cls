public without sharing class WithoutSharingClass {
    
    public static List<Flower__c> getEmployees(){
        return [Select Id from Flower__c];
    }
    
   
    
}
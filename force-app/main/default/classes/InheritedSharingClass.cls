public inherited sharing class InheritedSharingClass {

     public static List<Flower__c> getEmployees(){
        return [Select Id from Flower__c];
    }
}
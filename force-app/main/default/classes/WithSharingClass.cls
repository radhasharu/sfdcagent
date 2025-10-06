public without sharing class WithSharingClass {
    
    public static List<Flower__c> getEmployees(){
        return [Select Id from Flower__c];
    }
    
     private with Sharing class InnerClass {
        public List<Flower__c>  innerMethod() {
            return [Select Id from Flower__c];
        }
    }
    
    public static List<Flower__c> outerMethod() {
        InnerClass innr = new InnerClass();
        return innr.innerMethod(); // Shares outer class context
    }

}
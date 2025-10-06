public class ACC_EmployeeAssistanceController {
    
    @TestVisible
    private static Boolean forceException = false;
    
    @AuraEnabled(cacheable=true)
    public static List<ACC_Project_Policy__c> getAllProjPolicies(){
        try {
            return [Select Name, Policy_Name__c, Policy_Status__c, Project__r.Name from 
                    ACC_Project_Policy__c Order by Project__r.Name ASC] ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    @AuraEnabled
    public static List<ACC_Employee__c> getEmployeeDetails(String empId){
        try {
            List<ACC_Employee__c> empList = new List<ACC_Employee__c>();
            empList =  [Select Id,Name,Employee_Name__c,Email__c,Phone__c,Primary_Skill__c,Secondary_Skill__c from 
                        ACC_Employee__c where Name = :empId] ;
            return empList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<ACC_Employee__c> getAllEmployees(){
        try {
            List<ACC_Employee__c> empList = new List<ACC_Employee__c>();
            empList =  [Select Id,Name,Employee_Name__c,Email__c,Phone__c,Primary_Skill__c,Secondary_Skill__c,Project__r.Name
                        from ACC_Employee__c] ;
            return empList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    
    
}
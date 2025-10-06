@isTest
private class ACC_EmployeeAssistanceController_Test {
    
    @testSetup
    static void testSetup(){
        ACC_Project__c proj = new ACC_Project__c(Name = 'Sodexo', Industry__c = 'Food Services',
                                                 Client__c	= 'ENEL', Location__c = 'India',Expected_Revenue__c = 20000000);
        insert proj;
        
        ACC_Project_Policy__c  projPol = new ACC_Project_Policy__c (Name = 'PP-230', Policy_Name__c = 'Handle Production deployment',
                                                                    Policy_Status__c	= 'Published', Project__c = proj.Id);
        insert projPol;
        ACC_Employee__c   emp = new ACC_Employee__c  (Employee_Name__c = 'Radha', Email__c = 'radha@test.com',
                                                      Phone__c	= '9988776655', Months_of_Experience__c = 34,
                                                      Project__c = proj.Id);
        insert emp;
        
        
    }
    
    @isTest
    static void getAllProjPolicies_Test() {
        Test.startTest();
       List<ACC_Project_Policy__c>  projPolicyList = ACC_EmployeeAssistanceController.getAllProjPolicies();
        Test.stopTest();
        System.assertEquals(1, projPolicyList.size());
    }
    
    @isTest
    static void getEmployeeDetails_Test() {  
        Test.startTest();
        List<ACC_Employee__c>  empList = ACC_EmployeeAssistanceController.getEmployeeDetails('test');
        Test.stopTest();
        System.assertEquals(0, empList.size());
    }
    @isTest
    static void getAllEmployees_Test() {
        Test.startTest();
        List<ACC_Employee__c>  empList = ACC_EmployeeAssistanceController.getAllEmployees();
        Test.stopTest();
        System.assertEquals(1, empList.size());
    }
}
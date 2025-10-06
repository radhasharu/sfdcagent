@isTest
private class Test_AutoConvertLead {
    
    static testMethod void convertLeaed(){
        Lead testLead =  new Lead(firstname='John',lastname='David',company='SLK',Status='Open - Not Contacted',email='radhasharu97@gmail.com');
        insert  testLead;
        List<Id> LeadIds = new List<Id>() ;
        LeadIds.add(testLead.Id);
        AutoConvertLead.LeadAssign(LeadIds);
       
        
        
    }

}
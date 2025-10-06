@isTest
private class TEST_LeadDetail {
	
    static testMethod void convertLead1(){
        Lead testLead =  new Lead(firstname='John',lastname='David',company='SLK',Status='Open - Not Contacted',email='radhasharu97@gmail.com');
        insert  testLead;
        ApexPages.StandardController sc = new ApexPages.StandardController(testLead);
        
        
        PageReference pageRef = Page.DEVC_CustomDetailPage2; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(testLead.Id));
        Test.setCurrentPage(pageRef);
        
        DEVC_LeadDetail test1 = new DEVC_LeadDetail(sc);
        DEVC_LeadDetail test2 = new DEVC_LeadDetail();
        
        test1.mwrapper = new  DEVC_LeadDetail.DEVC_ModalWrapper();
        test1.mwrapper.accSite='slkgroup.com';
        test1.mwrapper.conEmail='abc@gmail.com';
        test1.mwrapper.oppName='testOpp1';
        test1.mwrapper.oppClosedDate=Date.today()+30;
        test1.mwrapper.selectedStage='Prospecting';
        test1.convert();
        
        test2.mwrapper = new  DEVC_LeadDetail.DEVC_ModalWrapper();
        test2.mwrapper.accSite='slkgroup.com';
        test2.mwrapper.conEmail='abc@gmail.com';
        test2.mwrapper.oppName='testOpp1';
        test2.mwrapper.oppClosedDate=Date.today()+30;
        test2.mwrapper.selectedStage='Prospecting';
        test2.convert();
       
        
        
        }
    
  
}
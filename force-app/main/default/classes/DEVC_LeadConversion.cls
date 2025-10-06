public without sharing class DEVC_LeadConversion {
    
       private ApexPages.standardController controller{get;set;}
       public Lead newlead{get;set;}
       
       public DEVC_LeadConversion (ApexPages.StandardController stdController){
       controller=stdController;
       newlead=(Lead)controller.getRecord();
       
       }
       
       public PageReference convert(){
           
        
           Account a=new Account(Name=newlead.Company);
           Insert a;
           Contact c= new Contact(FirstName=newlead.FirstName, LastName=newlead.LastName);
           Insert c;
         
           Delete newlead;
            PageReference pr =  Page.HelloWorld;
              controller.save(); 
               pr.setRedirect(true);
            return pr;
       }
  
    
    
}
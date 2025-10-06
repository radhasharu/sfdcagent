public class DEVC_LeadDetail{
public String leadId{ get; set;}
public Lead lead{ get; set;}
public boolean displayPopup {get; set;}   
public DEVC_ModalWrapper mwrapper{get;set;}
public List<SelectOption> stageOptions{get;set;}


public DEVC_LeadDetail(ApexPages.StandardController stdController){
    mwrapper= new DEVC_ModalWrapper();
  //String fullURL = ApexPages.currentPage().getURL();
    leadId = ApexPages.CurrentPage().getparameters().get('id');
    lead=[SELECT firstname,lastname,email,phone,company FROM Lead where id = :leadId];
    getSelectStage();
}

public DEVC_LeadDetail(){
  
    mwrapper= new DEVC_ModalWrapper();
    leadId = ApexPages.CurrentPage().getparameters().get('id');
    lead=[SELECT firstname,lastname,name,email,phone,company FROM Lead where id = :leadId];
    getSelectStage();
   
    
}

public void getSelectStage(){
    stageOptions= new List<SelectOption>();
    stageOptions.add(new SelectOption('','-None-'));
    stageOptions.add(new SelectOption('Prospecting','Prospecting'));
    stageOptions.add(new SelectOption('Qualification','Qualification'));
    stageOptions.add(new SelectOption('Price Quote','Price Quote'));
    stageOptions.add(new SelectOption('Closed','Closed'));
  

}
public  void convert() {
     String accId,conId,oppId;
    try{
    if(String.isNotBlank(mwrapper.accSite)){
        Account  acc = new Account(Name=lead.company, Phone=lead.phone,Site=mwrapper.accSite);
        database.insert(acc);
       accId=acc.id;
        
         
        
    }
    if(String.isNotBlank(mwrapper.conEmail)){
        Contact  c= new Contact(FirstName=lead.FirstName, LastName=lead.LastName,Email=mwrapper.conEmail);
         Insert c;
          conId=c.id;
    }
    if(string.isNotBlank(mwrapper.oppName)){
        Opportunity opp= new Opportunity();
        opp.name=mwrapper.oppName;
        opp.stageName=mwrapper.selectedStage;
        opp.closedate= mwrapper.oppClosedDate;
        insert opp;
        oppId=opp.id;
    }
  
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Lead is converted to '+ 'Account = ' + accId +'\nContact = '+conId+'\nOpportunity = '+oppId));
   // closePopup();
    }catch(Exception e)
    {
        System.debug('Error is ===' + e.getMessage() + ' error at===' + e.getStackTraceString() );
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, ' Cannot Convert Lead due to ' + e.getMessage()));
    }
  
}


public void closePopup() {        
    displayPopup = false;    
}     
public void showPopup() {        
    displayPopup = true;    
}

 public class DEVC_ModalWrapper{
    
    public Date oppClosedDate {get; set;}
    public String selectedStage{get;set;}
    public String oppName{get; set;}
    public String accSite{get;set;}
    public String conEmail{get; set;}
    
    public DEVC_ModalWrapper(){
        
        this.oppClosedDate=Date.today()+30;
        this.selectedStage='';
        this.oppName='';
        this.accSite='';
        this.conEmail='';
    }
    
    
}

}
public class DEVC_CustomLeadController {
    
    public DEVC_ModalWrapper mwrapper{get;set;}
    public String leadId{get;set;}
    public List<String> objNames{get;set;}
    public Lead leadToConvert{get; set;}
    
    public DEVC_CustomLeadController(){
        mwrapper = new DEVC_ModalWrapper();
        leadId = ApexPages.currentPage().getParameters().get('id');
        objNames = new List<String>();
        objNames.add('Account');
        objNames.add('Contact');
        objNames.add('Opportunity');
        leadToConvert = [SELECT id,firstname,lastname,email FROM Lead where id = :leadId];
        
        
    }
    
    public pagereference convertIntoObjects(List<String> objNames ){
        if(objNames.contains('Opportunity')){            
        	Opportunity opp = new Opportunity();
        	opp.Name=leadToConvert.FirstName+' '+ leadToConvert.LastName;
            database.insert(opp);
        }
        return null;
    }
    public class DEVC_ModalWrapper{
        
        String accIndustry{get; set; }
        String oppStage {get; set;}
        String conEmail {get; set;}
        Date oppClosedDate {get; set;}
        
        public DEVC_ModalWrapper(){
            this.accIndustry='';
            this.oppStage='';
            this.conEmail='';
            this.oppClosedDate=Date.today()+30;
        }
        
        
    }
    
    

}
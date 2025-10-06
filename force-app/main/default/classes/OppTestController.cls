public class OppTestController {
    public Opportunity cont;

  public OppTestController(ApexPages.StandardController controller){

   Opportunity cont = (Opportunity)controller.getRecord();
    cont=[select id,StageName,Status_Changed__c from Opportunity where Id=: cont.ID];

  }
  public void setAlertVal(){
     cont.Status_Changed__c = false;
     update cont;
  }

}
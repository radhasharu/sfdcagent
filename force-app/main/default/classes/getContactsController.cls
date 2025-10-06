public class getContactsController {
    
    @AuraEnabled
    public static Integer getContactCount(){
        
        AggregateResult[] cList = [Select count(id) totalCount from Contact];
        return (Integer) cList[0].get('totalCount');

        
    }

}
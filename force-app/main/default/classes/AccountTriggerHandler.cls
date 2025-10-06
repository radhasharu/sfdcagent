public class AccountTriggerHandler {
    
    public static void setIndustry(List<Account> newAccList){
        for(Account acc : newAccList){
            
            acc.Industry = 'Education';
        }
    }
    
    public static void checkType(List<Account> newAccList){
        
        for(Account acc : newAccList){
            if(String.isBlank(acc.Type)){
                acc.addError('Please enter the Type field value');
            }
        }
    }
    public static void updateIndustry(List<Account> newAccList,Map<Id,Account> oldAccMap){
        for(Account acc : newAccList){
            if(oldAccMap.get(acc.Id).AnnualRevenue != 10000 &&
               acc.AnnualRevenue == 10000){
                   acc.Industry = 'Agriculture';
               }
        }
        
    }
    
     public static void createContact(List<Account> newAccList){
         
         //for(Account acc: newAccList){
         List<Contact> conListToInsert = new List<Contact>();
         for(Integer i=0 ;i<newAccList.size() ;i++){
             Contact con = new Contact(LastName = 'Contact'+i,AccountId = newAccList[i].Id);
             conListToInsert.add(con);
         }
         insert conListToInsert;
         
     }
    
    
    
    
    
}
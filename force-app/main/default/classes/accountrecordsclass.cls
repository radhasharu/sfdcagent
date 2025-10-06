public class accountrecordsclass
{
    public LIst<account> acclist{get;set;}
    
    public accountrecordsclass()
    {
        acclist =[select id,name,accountnumber from account limit 10];
        
        //write the query according to your requirement
    }
    
    
}
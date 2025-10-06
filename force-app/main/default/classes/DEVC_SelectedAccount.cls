public class DEVC_SelectedAccount{

    
    
    List<Account> accounts;
    
    
    public List<Account>getAccounts() {
         accounts=[SELECT Name,Phone,Site FROM Account where Name='TCS' LIMIT 10];
        return accounts;
    }


}
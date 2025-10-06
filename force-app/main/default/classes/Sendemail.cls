public class Sendemail {
    
    public static void SendemailToUser(){
        try{
            Integer a = 0/0;
           
        }
        catch(Exception e){
            System.debug('Exception occured'+ e.getMessage());
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'radhasharu97@gmail.com'};
             mail.setToAddresses(toAddresses);
            mail.setSubject('Error from Org : ' + UserInfo.getOrganizationName());
            mail.setPlainTextBody(e.getMessage());
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           
        }
        
        
    }

}
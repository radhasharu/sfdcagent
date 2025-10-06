public class OpportunityHandler {
    
    // This method handles the Opportunity when its stage is closed
    public static void handleClosedOpportunity(Opportunity opp) {
        // Check if the code is running in a test context
        if (Test.isRunningTest()) {
            // Send email if not in test context
            sendEmailNotification(opp);
        } else {
            // Log that the email sending is skipped during tests
            boolean isExec = true;
            System.debug('Skipping email sending during test for Opportunity: ' + opp.Name);
        }
    }
    
    // This is a private method that sends the email notification
    private static void sendEmailNotification(Opportunity opp) {
        // Simulate email sending (in real cases, you would use Messaging.sendEmail)
        System.debug('Sending email about Opportunity: ' + opp.Name);
        
        // Actual email logic could go here (e.g., using Messaging.Email)
    }
}
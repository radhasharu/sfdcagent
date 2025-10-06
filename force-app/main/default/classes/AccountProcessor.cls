public class AccountProcessor {

    // Public method to process an Account and apply a discount if necessary
    public static void processAccount(Id accountId) {
        // Query the Account record
        Account acc = [SELECT Id, Name, AnnualRevenue FROM Account WHERE Id = :accountId LIMIT 1];
        
        // Check if AnnualRevenue exceeds the threshold
        if (acc.AnnualRevenue > 1000000) {
            // If revenue is over 1 million, apply a discount
            Double discount = calculateDiscount(Double.valueOf(acc.AnnualRevenue));
            System.debug('Discount applied: ' + discount);
            
            // You can apply the discount to the account here if needed
            acc.AnnualRevenue -= discount;
            update acc;
        } else {
            Boolean isExec= true;
            System.debug('No discount applied as AnnualRevenue is below threshold.');
        }
    }

    // Private helper method to calculate a discount based on AnnualRevenue
   @TestVisible
     private static Double calculateDiscount(Double annualRevenue) {
        // Calculate a discount based on revenue
        Double discount = 0;
        if (annualRevenue > 1000000) {
            discount = annualRevenue * 0.1;  // 10% discount for revenue > 1 million
        }
        return discount;
    }
}
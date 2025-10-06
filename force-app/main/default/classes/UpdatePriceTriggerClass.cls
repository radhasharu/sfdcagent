public class UpdatePriceTriggerClass {
    
    public static void insertPrice(Product__c product){
       
        UpdatePriceTriggerActionClass.insertPrice(product);
     }
    
    public static void updateFee(Product__c product,Decimal price){
       
        UpdatePriceTriggerActionClass.updateFee(product,price);
    }
    
}
public class UpdatePriceTriggerActionClass {
    public static void insertPrice(Product__c product){
        product.Product_Price__c = 100;
    }
    public static void updateFee(Product__c product,Decimal price){
        product.Product_Fee__c = price;
    }
 
}
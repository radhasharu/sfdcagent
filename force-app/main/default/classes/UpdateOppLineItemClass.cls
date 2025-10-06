public class UpdateOppLineItemClass {
    
    public static void afterInsert(String locPreferred,Id Id,String noPeople){
        
        
        List<OpportunityLineItem> itemToInsert = new List<OpportunityLineItem>();
        
        Product2 product = [SELECT ID,ProductCode FROM Product2 where Name =:locPreferred];
        system.debug(product);
        String productCode=product.ProductCode;
        Pricebook2 pb = [SELECT ID FROM Pricebook2 where Name =:noPeople];
        system.debug(pb);
        List<PricebookEntry> pbe = [SELECT ID,ProductCode,UnitPrice FROM PricebookEntry where Pricebook2Id =:pb.Id];
        
        system.debug(pbe);
        for(PricebookEntry pe: pbe){
            
            system.debug('pricebookid is==='+pe.ProductCode);
            system.debug('product id is==='+productCode);
            if(pe.ProductCode == productCode){
                
                OpportunityLineItem	lineItem = new OpportunityLineItem();
                lineItem.Product2Id=pe.Id;
                lineItem.Quantity=1;
                lineItem.OpportunityId=Id;
                lineItem.UnitPrice=pe.UnitPrice;
                
                itemToInsert.add(lineItem);
            }
        }
        
        
        
        insert itemToInsert;
        
        
    }
    
   
    
    
}
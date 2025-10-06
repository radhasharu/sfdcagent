public class OpportunityListClass {
    public List<Opportunity> opportunities;
    public List<Opportunity> searchOpportunity{get;set;}
    private integer OffsetSize = 0;
    private integer LimitSize= 10;
    public integer total_size;
    public String searchKey{get;set;}
    public boolean displaySearch{get;set;}
    public boolean display{get;set;}
    
    public OpportunityListClass(){
        display=true;
        displaySearch=false;
        total_size=[select count() from Opportunity];
       
    }
    
    public PageReference clearOpp(){
        searchKey='';
        getOpportunities();
        return null;
    }
    
    public List<Opportunity> getOpportunities(){
        display=true;
        displaySearch=false;
        opportunities = [SELECT ID,Name,StageName,CloseDate,AccountId FROM Opportunity Order by Name LIMIT :LimitSize OFFSET :OffsetSize];
        system.debug(opportunities);
        return opportunities;
    }
    
    public void Beginning() {  
        OffsetSize = 0;
    }
    
    public void Previous() { 
        OffsetSize = OffsetSize - LimitSize;
    }
    
    public void Next() {   
        OffsetSize = OffsetSize + LimitSize;
    }
    
    public void End() {    
        OffsetSize = total_size - math.mod(total_size , LimitSize);
    }
    
    
    public boolean getprev() {
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxt(){
        if((OffsetSize + LimitSize) > total_size)
            return true;
        else
            return false;
    }
    
    public void Search(){
        display=false;
        displaySearch=true;
        String searchString = '%' + searchKey + '%';
        searchOpportunity=[select Id,Name,StageName,CloseDate,AccountId from Opportunity where name like :searchString or stageName like :searchString or AccountId = :searchString  Limit 10];
        system.debug('search ====' + searchOpportunity);
    }
    public PageReference save(){
        update opportunities;
       // update searchOpportunity;
        return null;
    }
    public PageReference saveSearch(){
       
        update searchOpportunity;
        return null;
    }
    
}
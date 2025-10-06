public class VehicleController {
    
    public List<Vehicle__c> vehicles;
    public List<Vehicle_Line_Item__c> details;
    public boolean showDetails{get;set;}
    public String vehicleMake{get;set;}
    public String vehicleModel{get; set;}
    public String vehicleId{get;set;}
    public AggregateResult[] vehicleDetails{get;set;}
    
    public List<Vehicle__c> getVehicles(){
        vehicles = [SELECT Name,Vehicle_Make__c,Num_of_Vehicles__c,Id FROM Vehicle__c];
        system.debug(vehicles);
        return vehicles;
    }
    
    public PageReference getDetails2(){
        
        getDetails();      
        return null;
    }
    public AggregateResult[] getDetails(){
        showDetails=true;
        System.debug(vehicleId);
        System.debug(vehicleMake);
        vehicleDetails = [SELECT Name,SUM(Total_Income__c)tot_income,SUM(Total_Kms_Driven__c)tot_driven,MAX(Vehicle_Reg_Date__c)max_date,MIN(Vehicle_Reg_Date__c)min_date
                          FROM Vehicle_Line_Item__c WHERE  Vehicle__c=:vehicleId GROUP BY Name ];
        System.debug(vehicleDetails);
        return vehicleDetails;
        
    }
}
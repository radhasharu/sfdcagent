public class OmittedSharing {
    
     public static List<Flower__c> getEmployees(){
        return [Select Id from Flower__c];
    }

    
     public static List<Flower__c> getEmployeesfromWithsharing(){
        return WithSharingClass.getEmployees();
    }
     public static List<Flower__c> getEmployeesfromWithoutsharing(){
        return WithoutSharingClass.getEmployees();
    }
     public static List<Flower__c> getEmployeesfromInheritedsharing(){
        return InheritedSharingClass.getEmployees();
    }
}
public with sharing class ExcelRecordHandler {
    @AuraEnabled
    public static void createRecords(String jsonData) {
        List<Object> records = (List<Object>) JSON.deserializeUntyped(jsonData);
        List<Account> sObjectRecords = new List<Account>();
        
        for (Object recordObj : records) {
            Map<String, Object> record = (Map<String, Object>) recordObj;
            Account sObjectRecord = new Account();
            sObjectRecord.Name = (String) record.get('Field1');
            sObjectRecord.Industry = (String) record.get('Field2');
            // Map other fields as necessary

            sObjectRecords.add(sObjectRecord);
        }

        if (!sObjectRecords.isEmpty()) {
            insert sObjectRecords;
        }
    }
}
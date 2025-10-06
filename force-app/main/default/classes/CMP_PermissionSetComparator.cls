public class CMP_PermissionSetComparator {
    @AuraEnabled(cacheable=true) 
    public static List<Object> getAllPermissionSets(){
        try{
            HttpRequest req = new HttpRequest();
            String query='select+Id,Name,Label+from+PermissionSet+where+isCustom=true';
            req.setEndpoint('callout:ap25/services/data/v49.0/queryAll/?q='+query);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse resp = http.send(req);
            if(resp.getStatusCode() == 200){
                system.debug('Body:'+resp.getBody());
                Map<String,Object> responseMap =  (Map<String,Object>)JSON.deserializeUntyped(resp.getBody());
                System.debug('responseMap'+responseMap.get('records'));
                List<Object> recordList =  (List<Object>)responseMap.get('records');
                System.debug('recordList'+recordList);
                return recordList; 
            }
            else{
                return null;
            }
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    @AuraEnabled
    public static Map<String,List<Object>> getSinglePermissionSetDetails(String psId){
        try{
            Map<String,List<Object>>  permSetMap = new Map<String,List<Object>>();
            List<Object> objPermissions= getObjectPermissions(psId);
            permSetMap.put('Object Permissions',objPermissions);
            List<Object> fieldPermissions= getFieldPermissions(psId);
            permSetMap.put('Field Permissions',fieldPermissions);
            List<Object> apexClassPermissions= getApexClassPermissions(psId);
             permSetMap.put('ApexClass Access',apexClassPermissions);
            return permSetMap;
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
    }
    
    @AuraEnabled
    public static List<Object> getObjectPermissions(String psId){
        try{
            Account[] acc = [Select Id,Name from Account];
            HttpRequest req = new HttpRequest();
            String query='select+Id,Parent.Name,Parent.Label,PermissionsCreate,PermissionsDelete,PermissionsEdit,'+
                'PermissionsModifyAllRecords,PermissionsRead,PermissionsViewAllRecords,SobjectType'+
                '+from+ObjectPermissions+where+ParentId=\''+psId+'\'';
            req.setEndpoint('callout:ap25/services/data/v49.0/queryAll/?q='+query);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse resp = http.send(req);
            system.debug('statusCode:'+resp.getStatusCode());
            if(resp.getStatusCode() == 200){
                system.debug('Body:'+resp.getBody());
                Map<String,Object> responseMap =  (Map<String,Object>)JSON.deserializeUntyped(resp.getBody());
                System.debug('responseList'+responseMap);
                List<Object> recordList =  (List<Object>)responseMap.get('records');
                System.debug('recordList'+recordList);
                return recordList; 
            }
            else{
                return null;
            }
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    @AuraEnabled
    public static List<Object> getFieldPermissions(String psId){
        try{
            Account[] acc = [Select Id,Name from Account];
            HttpRequest req = new HttpRequest();
            String query='select+Id,Parent.Name,Parent.Label,Field,PermissionsEdit,PermissionsRead,SobjectType'+
                '+from+FieldPermissions+where+ParentId=\''+psId+'\'';
            req.setEndpoint('callout:ap25/services/data/v49.0/queryAll/?q='+query);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse resp = http.send(req);
            system.debug('statusCode:'+resp.getStatusCode());
            if(resp.getStatusCode() == 200){
                system.debug('Body:'+resp.getBody());
                Map<String,Object> responseMap =  (Map<String,Object>)JSON.deserializeUntyped(resp.getBody());
                System.debug('responseList'+responseMap);
                List<Object> recordList =  (List<Object>)responseMap.get('records');
                System.debug('recordList'+recordList);
                return recordList; 
            }
            else{
                return null;
            }
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    @AuraEnabled
    public static List<Object> getApexClassPermissions(String psId){
        try{
            Account[] acc = [Select Id,Name from Account];
            HttpRequest req = new HttpRequest();
            String query='SELECT+ParentId,SetupEntityId+FROM+SetupEntityAccess+where+SetupEntityType=\'ApexClass\'+and+ParentId=\''+psId+'\'';
            req.setEndpoint('callout:ap25/services/data/v49.0/queryAll/?q='+query);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse resp = http.send(req);
            system.debug('statusCode:'+resp.getStatusCode());
            if(resp.getStatusCode() == 200){
                system.debug('Body:'+resp.getBody());
                Map<String,Object> responseMap =  (Map<String,Object>)JSON.deserializeUntyped(resp.getBody());
                System.debug('responseList'+responseMap);
                List<Object> recordList =  (List<Object>)responseMap.get('records');
                System.debug('recordList'+recordList);
                List<String> apexClassId = new List<String>();
                String apexClassIds;
                if(recordList.size() > 0){
                    apexClassIds = '(';
                    for(Object obj :recordList){
                        Map<String,Object> objDetails =  (Map<String,Object>)obj;
                        System.debug(objDetails.get('SetupEntityId'));
                         apexClassIds += '\''+(String)objDetails.get('SetupEntityId') +'\'' +',';
                    }
                    apexClassIds = apexClassIds.removeEnd(',');
                    apexClassIds += ')';
                    if(apexClassIds !=  null){
                        HttpRequest req1 = new HttpRequest();
                        String query1='select+Id,Name+from+ApexClass+where+Id+in+'+apexClassIds;
                        req1.setEndpoint('callout:ap25/services/data/v49.0/queryAll/?q='+query1);
                        req1.setMethod('GET');
                        Http http1 = new Http();
                        HTTPResponse resp1 = http1.send(req1);
                        system.debug('statusCode:'+resp1.getStatusCode());
                        if(resp1.getStatusCode() == 200){
                            system.debug('Body:'+resp1.getBody());
                            Map<String,Object> responseMap1 =  (Map<String,Object>)JSON.deserializeUntyped(resp1.getBody());
                            System.debug('responseList'+responseMap1);
                            List<Object> recordList1 =  (List<Object>)responseMap1.get('records');
                            System.debug('recordList'+recordList1);
                            return recordList1; 
                        }
                        else{
                            return null;
                        }
                        
                    }
                    
                    else{
                        return null;
                    }
                }
                else{
                    return null;
                }
            }
            else{
                return null;
            }
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    
}
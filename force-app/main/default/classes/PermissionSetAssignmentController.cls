public class PermissionSetAssignmentController {
    
    @AuraEnabled 
    public static List<User> getUsers(String searchString,String userSearchField){
        try{
            List<User> userList = new List<User>();
            if(searchString.startsWith('005') && userSearchField == 'Id' ){
                userList = [Select Id,name, Username,Email from User where Id = :searchString];
            }
            else{
                String likeString = '\'%'+searchString+'%\'';
                String queryString = 'Select Id,name, Username,Email from User where ' + userSearchField + ' LIKE ' + likeString ;
                userList = Database.query(queryString);
            }
            return userList;
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    @AuraEnabled 
    public static List<PermissionSet> getPS(String searchString , String psSearchField){
        try{
            List<PermissionSet> psList = new List<PermissionSet>();
            if(searchString.startsWith('0PS') && psSearchField == 'Id'){
                psList = [Select Id,name from PermissionSet where Id = :searchString];
            }
            else{
                String likeString = '\'%'+searchString+'%\'';
                String psqueryString = 'Select Id,name from PermissionSet where ' + psSearchField + ' LIKE ' +likeString;
                psList = Database.query(psqueryString);
                
            }
            return psList;
        }
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    @AuraEnabled 
    public static List<PSWrapper> assignPS(List<String> selectedUsers, List<String> selectedPS){
        try{
            List<PSWrapper> psWrapList = new List<PSWrapper>();
            List<PermissionSetAssignment> psAssignList = new List<PermissionSetAssignment>();
            Map<Id,User> userMap = new Map<Id,User>([Select Id, Name,Username from User where Id IN :selectedUsers]);
            Map<Id,PermissionSet> psMap = new Map<Id,PermissionSet>([Select Id, Name from PermissionSet where Id IN :selectedPS]);
            if(selectedUsers.size() > 0 && selectedPS.size() > 0){
                for(Integer i = 0; i < selectedUsers.size() ; i++){
                    for(Integer j = 0; j < selectedPS.size() ; j++){
                        psAssignList.add(new PermissionSetAssignment(
                            PermissionSetId = selectedPS[j],
                            AssigneeId = selectedUsers[i]) );
                    }
                }
            }
            List<Database.SaveResult> insertResults = Database.insert(psAssignList,false);
            for( integer i=0; i < insertResults.size(); i++ ){
                if (insertResults[i].isSuccess()) {
                    PSWrapper wrap =  new PSWrapper();
                    wrap.userId = psAssignList[i].AssigneeId;
                    wrap.userName = userMap.get(psAssignList[i].AssigneeId).Username;
                    wrap.psId = psAssignList[i].PermissionSetId;
                    wrap.psName = psMap.get(psAssignList[i].PermissionSetId).Name;
                    wrap.result = 'Successfully Assigned';
                    psWrapList.add(wrap);
                    
                }
                else if(! insertResults[i].isSuccess()){
                    Database.Error dbError = insertResults[i].getErrors()[0];
                    PSWrapper wrap =  new PSWrapper();
                    wrap.userId = psAssignList[i].AssigneeId;
                    wrap.userName = userMap.get(psAssignList[i].AssigneeId).Name;
                    wrap.psId = psAssignList[i].PermissionSetId;
                    wrap.psName = psMap.get(psAssignList[i].PermissionSetId).Name;
                    wrap.result = dbError.getMessage();
                    psWrapList.add(wrap);
                }
            }
            return psWrapList;
        }
        
        catch(Exception e){
            System.debug('Exception occured ==>'+e.getMessage() + 'at Line number ==>'+e.getLineNumber());
            return null;
        }
        
    }
    
    public class PSWrapper{
        @AuraEnabled
        public String userId;
        @AuraEnabled
        public String psId;
        @AuraEnabled
        public String userName;
        @AuraEnabled
        public String psName;
        @AuraEnabled
        public String result;
        
    }
    
}
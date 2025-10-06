({
    OppHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Opportunity Name', fieldName: 'Name', type: 'text'},
            {label: 'Account Name', fieldName: 'AccountName', type: 'text'},
            {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
            
            {label: 'Close Date', fieldName: 'CloseDate', type: 'date '},
            
        ]);
            var action = component.get("c.fetchOpp");
            
            action.setCallback(this, function(response){
            var state = response.getState();
            
            
            if (state === "SUCCESS") {
            //component.set("v.oppList", response.getReturnValue());
            var rows = response.getReturnValue();
            
            for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
                      // checking if any account related data in row
                      if (row.Account) {
            row.AccountName = row.Account.Name;
            
        }
        
    }
}
 component.set("v.oppList", rows);
});
$A.enqueueAction(action);
    }
})
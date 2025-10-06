({
    handleMessage : function(component, message, helper) {
        if(message != null && message.getParam('lmsData') != null){
            component.set('v.messageReceived', message.getParam('lmsData').value);
          }
    },

    publishMessage: function(component, event, helper) {
        let message = {
            lmsData :{
                value : component.get('v.enteredMessage')
            }
        }
        component.find('SampleMessageChannel').publish(message);
    }

})
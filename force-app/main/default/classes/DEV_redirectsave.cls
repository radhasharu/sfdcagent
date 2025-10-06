public without sharing class DEV_redirectsave{

    public DEV_redirectsave(Apexpages.StandardController  stdCtrl){
        
    }
    
    public PageReference save_redirect(){
    
        PageReference pr =  Page.HelloWorld;
        system.debug('redirect to another page');
        pr.setRedirect(true);
        return pr;
    }
}
public without sharing class DEVC_MyCustomController {

    
    public String urlParam { get; set;}
    
    public DEVC_MyCustomController(){
        urlParam='empty';
    }
  
    public PageReference getUrlParam() {
        /*PageReference pr =  Page.HelloWorld;
        system.debug('redirect to another page');
        pr.setRedirect(true);
        return pr;   */
        urlParam = 'Hi Apoorva';
        return null;
                     
         }

}
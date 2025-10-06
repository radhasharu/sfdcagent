public class CalloutAnimal {
    public static HttpResponse animals(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"Name":"Lion"}');
        
        HttpResponse res = http.send(req);
        System.debug('Status :'+ res.getStatusCode());
        System.debug('Status :'+ res.getStatus());
        System.debug(res.getBody());
        return res;
    }
}
@isTest
public class CalloutAnimal_Test {
    @isTest
    static void testAnimals(){
        Test.setMock(HttpCalloutMock.class, new AnimalsCalloutMock());
        
        HttpResponse res = CalloutAnimal.animals();
        String expected = '{"Animals":["Horse","Dog","Tiger","Lion","Cat","Mouse"]}' ;
        
        System.assertEquals(200,res.getStatusCode());
        System.assertEquals(res.getBody(), expected);
    }
    
    public class AnimalsCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HttpRequest req){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type','application/json');
            res.setBody('{"Animals":["Horse","Dog","Tiger","Lion","Cat","Mouse"]}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    
}
public class ShopExcitingAsyncClass {
    
    @future(callout=true)
    public static void addProduct(String jsonString){
        List<String> product_id= new List<String>();
        
        List<Product2> productList = (List<Product2>)Json.deserialize(jsonString,List<Product2>.class);
        
        
        
        for(Product2 product : productList){
            try{
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                Blob headerValue = Blob.valueOf('f46c0050c2f6589ba8efa8e4cd736c95:32e9431c7202d6c5a2ed45ff5c231355');
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                request.setHeader('Authorization', authorizationHeader);
                request.setEndpoint('https://shop-exciting.myshopify.com/admin/api/2020-01/products.json');
                request.setMethod('POST');
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                // Set the body as a JSON object
                System.debug('Check==' +product.Name);
                System.debug('Check==' +product.Product_Description__c);
                System.debug('Check==' +product.Vendor__c);
                System.debug('Check==' +product.Product_Type__c + '===' + product.Product_Image__c);
                System.debug('Check Size=='+product.size__c);
                
                List<String> selectedSize = new List<String>();
                selectedSize.addAll(product.size__c.split(';'));
                
                JSONGenerator gen = JSON.createGenerator(true); 
                
                gen.writeStartObject();     
                gen.writeFieldName('product');
                gen.writeStartObject();
                if(product.Name==NULL)
                    gen.writeNullField('title');
                else
                    gen.writeStringField('title', product.Name);
                if(product.Product_Description__c==NULL)
                    gen.writeNullField('body_html');
                else
                    gen.writeStringField('body_html', product.Product_Description__c);
                if(product.Vendor__c==NULL)
                    gen.writeNullField('vendor');
                else
                    gen.writeStringField('vendor',product.Vendor__c);
                if(product.Product_Type__c==NULL)
                    gen.writeNullField('product_type');
                else
                    gen.writeStringField('product_type',product.Product_Type__c);
                gen.writeFieldName('images');
                gen.writeStartArray();
                gen.writeStartObject();
                gen.writeStringField('src',product.Product_Image__c);
                gen.writeEndObject();
                gen.writeEndArray();
                
                gen.writeFieldName('options');
                gen.writeStartArray();
                gen.writeStartObject();
                gen.writeStringField('name','size');
                gen.writeFieldName('values');
                gen.writeStartArray();
                for(Integer i=0;i<selectedSize.size();i++){
                    gen.writeString(selectedSize[i]);
                }
                gen.writeEndArray();
                gen.writeEndObject();
                gen.writeEndArray();
                
                gen.writeFieldName('variants');
                gen.writeStartArray();
                for(Integer i=0;i<selectedSize.size();i++){
                    gen.writeStartObject();
                    gen.writeStringField('option1', selectedSize[i]);
                    gen.writeStringField('price', String.valueOf(product.Price__c.format()));
                    gen.writeEndObject();
                }
                gen.writeEndArray();
                
                
                
                gen.writeEndObject();
                gen.writeEndObject();
                
                String jsonS = gen.getAsString();
                System.debug('jsonMaterials == '+jsonS);
                
                
                
                //request.setBody('{"product": {"title": "Burton Custom Freestyle 151","body_html": "<strong>Good snowboard!</strong>","vendor": "Burton","product_type": "Snowboard","images": [{"src": "http://example.com/rails_logo.gif"}]}}');
                // request.setBody('{"product": {"title":' + product.Name +',"body_html":' + product.Product_Description__c+',"vendor":'+ product.Vendor__c+',"product_type":'+product.Product_Type__c+',"images": [{"src":'+ product.Product_Image__c+ '}]}}');
                request.setBody(jsonS);
                // request.setBody('{   "product": {     "title": "Burton 151",     "body_html": "<strong>Good snowboard!</strong>",     "vendor": "Burton",     "product_type": "Snowboard",     "variants": [       {         "option1": "Blue",         "option2": "XS" 		"option3" : "S" 		"quantiy" : 4 		"amount":1200       },       {         "option1": "Black",         "option2": "XS" 		"option3" : "S" 		"quantiy" : 4 		"amount":1200       }     ],     "options": [       {         "name": "Color",         "values": [           "Blue",           "Black"         ]       },       {         "name": "Size",         "values": [           "XS",           "S"         ]       }     ]   } }');
                HttpResponse response = http.send(request);
                // Parse the JSON response
                if (response.getStatusCode() != 201) {
                    System.debug('The status code returned was not expected: ' +
                                 response.getStatusCode() + ' ' + response.getStatus());
                } else {
                    System.debug(response.getBody());
                    JSONParser parser = JSON.createParser(response.getBody());
                    while (parser.nextToken() != null) {
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                            (parser.getText() == 'id')) {
                                parser.nextToken();
                                System.debug(parser.getText());
                                // System.debug('Id == ' +parser.getText().split('/')[4] );
                                product_id.add(parser.getText()); 
                            }
                        
                    }
                    product.Product_Id__c = product_id.get(0);
                    System.debug('Id1 == ' +product.Product_Id__c);
                }
                update product;
                
            }
            catch(Exception e)
            {
                system.debug('erroe == ' + e.getMessage());
            }
            
        }
        
    }
    @future(callout=true)
    public static void deleteProduct(String jsonString){
        List<Product2> productList = (List<Product2>)Json.deserialize(jsonString,List<Product2>.class);
        
        for(Product2 product : productList){
            try{
                String product_id = product.Product_Id__c;
                System.debug('Product Id==='+product_id);
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                Blob headerValue = Blob.valueOf('f46c0050c2f6589ba8efa8e4cd736c95:32e9431c7202d6c5a2ed45ff5c231355');
                String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
                request.setHeader('Authorization', authorizationHeader);
                request.setEndpoint('https://shop-exciting.myshopify.com/admin/api/2020-01/products/'+product_id +'.json');
                request.setMethod('DELETE');
                HttpResponse response = http.send(request);
                // If the request is successful, parse the JSON response.
                if (response.getStatusCode() == 200) {
                    System.debug('Product deleted successfully');
                }
                
            }
            catch(Exception e)
            {
                system.debug('erroe == ' + e.getMessage());
            }
            
        }
    }

    
}
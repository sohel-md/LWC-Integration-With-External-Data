public class ExternalDataCallout {
    
    @AuraEnabled
    public static list<AccountsWrapper> getAccountDetails(){
        list<AccountsWrapper> postalList = new list<AccountsWrapper>();
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://mocki.io/v1/0cf842e2-8624-49a4-8b44-f540552f1efb');
        req.setMethod('GET');
        HttpResponse hresp = http.send(req);
        System.debug('Response ### '+hresp.getBody());
        if(hresp.getStatusCode() ==200){
            JSONParser parser = JSON.createParser(hresp.getBody()); 
            parser.nextToken();
            while(parser.nextToken()!=NULL){
                if(parser.getcurrentToken() == JSONTOKEN.START_OBJECT) {
                    system.debug('start object ');
                    AccountsWrapper eachAccount = (AccountsWrapper)parser.readValueAs(AccountsWrapper.class);
                    system.debug('eachAccount'+eachAccount);
                    postalList.add(eachAccount);
                    
                }   
            }
        }
        system.debug('postalList'+postalList);
        return postalList;
    }
    
    public class AccountsWrapper {
        @AuraEnabled
        public string Name;
        
        @AuraEnabled
        public string Description;
    }
}
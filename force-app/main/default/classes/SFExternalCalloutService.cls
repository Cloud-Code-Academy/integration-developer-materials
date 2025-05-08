/**
 * Service class to handle callouts to external Salesforce org
 */
public class SFExternalCalloutService {
    // API endpoints
    private static final String LIMITS_ENDPOINT = '/services/data/v63.0/limits';
    private static final String ACCOUNT_ENDPOINT = '/services/data/v63.0/sobjects/Account';
    public static String grantType = 'password';
    
    /**
     * Gets the org limits from the external Salesforce org
     * @return Map containing the limits information
     */
    public static Map<String, Object> getLimits() {
        SFAuthenticationService.AuthResponse auth = SFAuthenticationService.authenticate(grantType);
        
        if (!auth.isSuccess) {
            System.debug('Authentication failed: ' + auth.errorMessage);
            return new Map<String, Object>{'error' => auth.errorMessage};
        }
        
        // Create HTTP request for limits
        HttpRequest req = new HttpRequest();
        req.setEndpoint(auth.instanceUrl + LIMITS_ENDPOINT);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + auth.accessToken);
        req.setHeader('Content-Type', 'application/json');
        
        // Send request
        Http http = new Http();
        HttpResponse res;
        
        try {
            res = http.send(req);
            
            if (res.getStatusCode() == 200) {
                Map<String, Object> limitsInfo = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                return limitsInfo;
            } else {
                System.debug('Error getting limits: ' + res.getStatusCode() + ' ' + res.getStatus());
                System.debug('Response body: ' + res.getBody());
                return new Map<String, Object>{'error' => 'Failed to get limits: ' + res.getStatus()};
            }
        } catch (Exception e) {
            System.debug('Exception getting limits: ' + e.getMessage());
            return new Map<String, Object>{'error' => 'Exception: ' + e.getMessage()};
        }
    }
    
    /**
     * Creates an Account in the external Salesforce org
     * @param accountName Name of the account to create
     * @return Id of the created account or error message
     */

    public static CreateAccountResult createAccount(String accountName) {
        SFAuthenticationService.AuthResponse auth = SFAuthenticationService.authenticate(grantType);
        
        if (!auth.isSuccess) {
            System.debug('Authentication failed: ' + auth.errorMessage);
            CreateAccountResult result = new CreateAccountResult();
            result.isSuccess = false;
            result.errorMessage = auth.errorMessage;
            return result;
        }
        
        // Prepare account data
        Map<String, Object> accountData = new Map<String, Object>{
            'Name' => accountName,
            'Description' => 'Created from external org via API',
            'Industry' => 'Technology',
            'Type' => 'Customer'
        };
        
        // Create HTTP request for account creation
        HttpRequest req = new HttpRequest();
        req.setEndpoint(auth.instanceUrl + ACCOUNT_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + auth.accessToken);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(accountData));
        
        // Send request
        Http http = new Http();
        HttpResponse res;
        
        try {
            res = http.send(req);
            
            if (res.getStatusCode() == 201) { // 201 Created
                Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                
                CreateAccountResult result = new CreateAccountResult();
                result.isSuccess = true;
                result.accountId = (String) responseData.get('id');
                return result;
            } else {
                System.debug('Error creating account: ' + res.getStatusCode() + ' ' + res.getStatus());
                System.debug('Response body: ' + res.getBody());
                
                CreateAccountResult result = new CreateAccountResult();
                result.isSuccess = false;
                result.errorMessage = 'Failed to create account: ' + res.getStatus() + ' - ' + res.getBody();
                return result;
            }
        } catch (Exception e) {
            System.debug('Exception creating account: ' + e.getMessage());
            
            CreateAccountResult result = new CreateAccountResult();
            result.isSuccess = false;
            result.errorMessage = 'Exception: ' + e.getMessage();
            return result;
        }
    }
    /**
     * Class to encapsulate account creation result
     */
    public class CreateAccountResult {
        public Boolean isSuccess;
        public String accountId;
        public String errorMessage;
    }
} 
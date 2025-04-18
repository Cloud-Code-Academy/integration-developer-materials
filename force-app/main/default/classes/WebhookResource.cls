@RestResource(urlMapping='/webhook/*') // /services/apexrest/webhook/jira
global with sharing class WebhookResource {

    @HttpGet
    global static String doGet() {
        RestRequest req = RestContext.request;
        System.debug(req);
        RestResponse res = RestContext.response;
        System.debug(res);
        String endingParam = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1).toLowerCase();
        
        if (endingParam == 'jira') {
            res.statusCode = 200;
            return 'Webhook is working';
        } else if (endingParam == 'github') {
            res.statusCode = 500;
            return 'Webhook encountered an error';
        } else {
            res.statusCode = 404;
            return 'Webhook not found';
        }
    }

    // @HttpPost
    // global static String doPost(String name,String phone, String website) {
    //     Account account = new Account();
    //     account.Name = name;
    //     account.phone = phone;
    //     account.website = website;
    //     insert account;
    //     return account.Id;
    // }


    @HttpPost
    global static String doPost() {
        RestRequest req = RestContext.request;
        System.debug(req);
        RestResponse res = RestContext.response;
        System.debug(res);

        String requestBody = req.requestBody.toString();
        Map<String, Object> requestBodyMap = (Map<String, Object>) JSON.deserializeUntyped(requestBody);
        System.debug('Request Body: ' + requestBodyMap);
        String endingParam = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1).toLowerCase();
        if (endingParam == 'jira') {
            // Process the request for Jira
            System.debug('Processing Jira webhook');
            // Add your logic here
        } else if (endingParam == 'github') {
            // Process the request for GitHub
            System.debug('Processing GitHub webhook');
            // Add your logic here
        } else {
            res.statusCode = 404;
            return 'Webhook not found';
        }
        return 'Webhook is working';
    }
}
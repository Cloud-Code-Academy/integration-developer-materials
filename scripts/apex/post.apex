// Instantiate a new Http object
String url = 'https://jsonplaceholder.typicode.com/posts/';
Http h = new Http();

    // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
HttpRequest req = new HttpRequest();
req.setEndpoint(url);
req.setMethod('POST');
String body = '{"title": "test","body": "test","userId": 1}';
req.setBody(body);

// Send the request, and return a response
HttpResponse res = h.send(req);
System.debug(res);
System.debug(res.getStatus());
System.debug(res.getStatusCode());
if (res.getStatusCode() == 200) {
    //Getting data
    System.debug(res.getBody());
} else if (res.getStatusCode() == 201) {
    //Process data that got created
    System.debug(JSON.serialize(res.getBody()));
}
else {
    System.debug('Error: ' + res.getStatus() + ' ' + res.getBody());
}

// System.debug(res.getBody());


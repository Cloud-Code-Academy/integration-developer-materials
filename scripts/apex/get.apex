// Instantiate a new Http object
String url = 'https://jsonplaceholder.typicode.com/post/';
Http h = new Http();

    // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
HttpRequest req = new HttpRequest();
req.setEndpoint(url);
req.setMethod('GET');

// Send the request, and return a response
HttpResponse res = h.send(req);
System.debug(res);
System.debug(res.getStatus());
System.debug(res.getStatusCode());
if (res.getStatusCode() == 200) {
    System.debug(res.getBody());
} else {
    System.debug('Error: ' + res.getStatus() + ' ' + res.getBody());
}

// System.debug(res.getBody());


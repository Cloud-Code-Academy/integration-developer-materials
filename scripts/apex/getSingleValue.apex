// Instantiate a new Http object
String url = 'https://jsonplaceholder.typicode.com/todos/1';
Http h = new Http();

    // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
HttpRequest req = new HttpRequest();
req.setEndpoint(url);
req.setMethod('GET');

// Send the request, and return a response
HttpResponse res = h.send(req);

List<Task> tasks = new List<Task>();
if (res.getStatusCode() == 200) {
    // Deserialize the JSON string into collections of primitive data types.
    system.debug(res.getBody());
    Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
    System.debug(results);
    System.debug('completed: ' + results.get('completed'));
    System.debug('id: ' + results.get('id'));
    System.debug('title: ' + results.get('title'));
    System.debug('userId: ' + results.get('userId'));
    Task t = new Task();
    String statusText = (Boolean) results.get('completed') ? 'Completed' : 'In Progress';
    t.Status = statusText;
    t.Subject = (String) results.get('title');
    t.Description = 'Id is ' + (Integer) results.get('id') + ' and userId is ' + (Integer) results.get('userId');
    t.Priority = 'Normal';
    tasks.add(t);
    
} else {
    System.debug('Error: ' + res.getStatus() + ' ' + res.getBody());
}


insert tasks;

System.debug(tasks);

/**
 * HttpMethodsDemo.cls
 *
 * This class shows the four main HTTP methods in action.
 * Each method has a specific purpose:
 * - GET: Read/Retrieve data
 * - POST: Create new data
 * - PUT: Update existing data
 * - DELETE: Remove data
 */
public class HttpMethodsDemo {
  // Base URL for all our requests
  private static final String BASE_URL = 'https://jsonplaceholder.typicode.com';

  /**
   * GET - Retrieves a resource
   * Run: HttpMethodsDemo.demonstrateGet();
   */
  public static void demonstrateGet() {
    System.debug('=== GET Method Demo ===');
    System.debug('Purpose: Retrieve data without modifying it');

    String endpoint = BASE_URL + '/posts/1';

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');

    HttpResponse response = http.send(request);

    System.debug('GET ' + endpoint);
    System.debug('Status: ' + response.getStatusCode());
    System.debug('Data retrieved: ' + response.getBody());
  }

  /**
   * POST - Creates a new resource
   * Run: HttpMethodsDemo.demonstratePost();
   */
  public static void demonstratePost() {
    System.debug('=== POST Method Demo ===');
    System.debug('Purpose: Create a new resource on the server');

    String endpoint = BASE_URL + '/posts';
    String newPost = '{"title": "New Post", "body": "Created with POST", "userId": 1}';

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setBody(newPost);
    request.setHeader('Content-Type', 'application/json');

    HttpResponse response = http.send(request);

    System.debug('POST ' + endpoint);
    System.debug('Sending: ' + newPost);
    System.debug('Status: ' + response.getStatusCode() + ' (201 = Created)');
    System.debug('Created resource: ' + response.getBody());
  }

  /**
   * PUT - Updates an existing resource
   * Run: HttpMethodsDemo.demonstratePut();
   */
  public static void demonstratePut() {
    System.debug('=== PUT Method Demo ===');
    System.debug('Purpose: Update an entire existing resource');

    String endpoint = BASE_URL + '/posts/1';
    String updatedPost = '{"id": 1, "title": "Updated Title", "body": "This post was updated", "userId": 1}';

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('PUT');
    request.setBody(updatedPost);
    request.setHeader('Content-Type', 'application/json');

    HttpResponse response = http.send(request);

    System.debug('PUT ' + endpoint);
    System.debug('Updating with: ' + updatedPost);
    System.debug('Status: ' + response.getStatusCode() + ' (200 = OK)');
    System.debug('Updated resource: ' + response.getBody());
  }

  /**
   * DELETE - Removes a resource
   * Run: HttpMethodsDemo.demonstrateDelete();
   */
  public static void demonstrateDelete() {
    System.debug('=== DELETE Method Demo ===');
    System.debug('Purpose: Remove a resource from the server');

    String endpoint = BASE_URL + '/posts/1';

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('DELETE');

    HttpResponse response = http.send(request);

    System.debug('DELETE ' + endpoint);
    System.debug('Status: ' + response.getStatusCode() + ' (200 = OK)');
    System.debug('Response: ' + response.getBody());
  }

  /**
   * Run all demos in sequence
   * Run: HttpMethodsDemo.runAllDemos();
   */
  public static void runAllDemos() {
    demonstrateGet();
    System.debug('\n');

    demonstratePost();
    System.debug('\n');

    demonstratePut();
    System.debug('\n');

    demonstrateDelete();

    System.debug('\n=== Summary ===');
    System.debug('GET: Read data (safe, no changes)');
    System.debug('POST: Create new data');
    System.debug('PUT: Update existing data');
    System.debug('DELETE: Remove data');
  }
}

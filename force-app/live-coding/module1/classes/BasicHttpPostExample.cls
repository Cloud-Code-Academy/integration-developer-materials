/**
 * BasicHttpPostExample.cls
 *
 * This class demonstrates how to send data to an API using POST requests.
 * We'll create new posts on the JSONPlaceholder API.
 *
 * Remember: POST is used to CREATE new resources!
 */
public class BasicHttpPostExample {
  /**
   * Creates a new post with hardcoded data
   * Run this in Anonymous Apex:
   * BasicHttpPostExample.createSimplePost();
   */
  public static void createSimplePost() {
    // The API endpoint for creating posts
    String endpoint = 'https://jsonplaceholder.typicode.com/posts';

    // Create the JSON body as a string (we'll learn better ways later!)
    String body = '{"title": "My First Post", "body": "Hello from Salesforce!", "userId": 1}';

    // Create our HTTP objects
    Http http = new Http();
    HttpRequest request = new HttpRequest();

    // Configure the request
    request.setEndpoint(endpoint);
    request.setMethod('POST'); // POST for creating!
    request.setBody(body); // Add our JSON data
    request.setHeader('Content-Type', 'application/json'); // Tell the API we're sending JSON

    // Send the request
    HttpResponse response = http.send(request);

    // Check if it worked (201 means "Created")
    if (response.getStatusCode() == 201) {
      System.debug('Success! Post was created!');
      System.debug('The API sent back: ' + response.getBody());
    } else {
      System.debug('Failed to create post');
      System.debug('Status: ' + response.getStatusCode());
      System.debug('Error: ' + response.getStatus());
    }
  }

  /**
   * Creates a post with custom data
   * Run this in Anonymous Apex:
   * BasicHttpPostExample.createCustomPost('My Title', 'My Content');
   */
  public static void createCustomPost(String postTitle, String postContent) {
    String endpoint = 'https://jsonplaceholder.typicode.com/posts';

    // Build JSON with the provided values
    // Note: In real apps, we'd use JSON.serialize() for safety!
    String body =
      '{"title": "' +
      postTitle +
      '", ' +
      '"body": "' +
      postContent +
      '", ' +
      '"userId": 1}';

    // Log what we're sending (helpful for debugging!)
    System.debug('Sending POST request with body: ' + body);

    Http http = new Http();
    HttpRequest request = new HttpRequest();

    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setBody(body);
    request.setHeader('Content-Type', 'application/json');

    HttpResponse response = http.send(request);

    // Handle different success codes (200-299 range)
    if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
      System.debug('Post created successfully!');
      System.debug('Response: ' + response.getBody());
    } else {
      System.debug('Error creating post: ' + response.getStatusCode());
    }
  }

  /**
   * Demonstrates what happens when we send bad data
   * Run this in Anonymous Apex:
   * BasicHttpPostExample.createBadPost();
   */
  public static void createBadPost() {
    String endpoint = 'https://jsonplaceholder.typicode.com/posts';

    // Intentionally malformed JSON (missing closing brace)
    String badBody = '{"title": "Oops", "body": "This JSON is broken"';

    Http http = new Http();
    HttpRequest request = new HttpRequest();

    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setBody(badBody);
    request.setHeader('Content-Type', 'application/json');

    try {
      HttpResponse response = http.send(request);
      System.debug('Status Code: ' + response.getStatusCode());
      System.debug('Response: ' + response.getBody());
    } catch (Exception e) {
      System.debug('Exception caught: ' + e.getMessage());
    }
  }
}

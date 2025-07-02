/**
 * BasicHttpGetExample.cls
 *
 * This class demonstrates the most basic HTTP GET request in Apex.
 * Perfect for beginners learning their first API callout!
 *
 * Before running this code:
 * 1. Go to Setup → Remote Site Settings
 * 2. Click "New Remote Site"
 * 3. Add URL: https://jsonplaceholder.typicode.com
 */
public class BasicHttpGetExample {
  /**
   * Makes a simple GET request to retrieve all posts
   * Run this in Anonymous Apex:
   * BasicHttpGetExample.getAllPosts();
   */
  public static void getAllPosts() {
    // Step 1: Create the endpoint URL
    String endpoint = 'https://jsonplaceholder.typicode.com/posts';

    // Step 2: Create the three core objects we need
    Http http = new Http(); // The HTTP handler
    HttpRequest request = new HttpRequest(); // The request container

    // Step 3: Configure the request
    request.setEndpoint(endpoint); // Where to send the request
    request.setMethod('GET'); // What type of request

    // Step 4: Send the request and get the response
    HttpResponse response = http.send(request);

    // Step 5: Check if it worked (200 means success!)
    if (response.getStatusCode() == 200) {
      System.debug('Success! Here is what we got back:');
      System.debug(response.getBody());
    } else {
      System.debug('Something went wrong!');
      System.debug('Status Code: ' + response.getStatusCode());
      System.debug('Error Message: ' + response.getStatus());
    }
  }

  /**
   * Gets a single post by ID
   * Run this in Anonymous Apex:
   * BasicHttpGetExample.getSinglePost(1);
   */
  public static void getSinglePost(Integer postId) {
    // Build the endpoint with the post ID
    String endpoint = 'https://jsonplaceholder.typicode.com/posts/' + postId;

    // Create our HTTP objects
    Http http = new Http();
    HttpRequest request = new HttpRequest();

    // Configure the request
    request.setEndpoint(endpoint);
    request.setMethod('GET');

    // Send and handle the response
    HttpResponse response = http.send(request);

    // Check the status code
    if (response.getStatusCode() == 200) {
      System.debug('Found post #' + postId + ':');
      System.debug(response.getBody());
    } else if (response.getStatusCode() == 404) {
      System.debug('Post #' + postId + ' was not found!');
    } else {
      System.debug('Unexpected error: ' + response.getStatusCode());
    }
  }
}

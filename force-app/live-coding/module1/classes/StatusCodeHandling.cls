/**
 * StatusCodeHandling.cls
 *
 * This class teaches you about HTTP status codes!
 * Status codes tell us if our request succeeded or failed, and why.
 *
 * Common Status Code Ranges:
 * - 1xx: Information (rare)
 * - 2xx: Success!
 * - 3xx: Redirection
 * - 4xx: Client error (we did something wrong)
 * - 5xx: Server error (the server has a problem)
 */
public class StatusCodeHandling {
  /**
   * Shows how to handle common status codes
   * Run: StatusCodeHandling.handleCommonStatusCodes();
   */
  public static void handleCommonStatusCodes() {
    // Try to get a post that exists
    checkStatusForEndpoint('/posts/1', 'Getting existing post');

    // Try to get a post that doesn't exist
    checkStatusForEndpoint('/posts/999', 'Getting non-existent post');

    // Try an invalid endpoint
    checkStatusForEndpoint('/invalid-endpoint', 'Using wrong endpoint');
  }

  /**
   * Helper method to check different endpoints
   */
  private static void checkStatusForEndpoint(String path, String description) {
    System.debug('\n=== ' + description + ' ===');

    String endpoint = 'https://jsonplaceholder.typicode.com' + path;

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');

    HttpResponse response = http.send(request);
    Integer statusCode = response.getStatusCode();

    System.debug('Endpoint: ' + endpoint);
    System.debug('Status Code: ' + statusCode);

    // Handle the status code
    handleStatusCode(statusCode, response);
  }

  /**
   * Demonstrates proper status code handling
   */
  private static void handleStatusCode(
    Integer statusCode,
    HttpResponse response
  ) {
    if (statusCode >= 200 && statusCode < 300) {
      // 2xx = Success!
      System.debug('✓ SUCCESS! The request worked perfectly.');

      if (statusCode == 200) {
        System.debug('  200 OK - Data retrieved successfully');
      } else if (statusCode == 201) {
        System.debug('  201 Created - New resource was created');
      } else if (statusCode == 204) {
        System.debug('  204 No Content - Success, but no data to return');
      }
    } else if (statusCode >= 300 && statusCode < 400) {
      // 3xx = Redirection
      System.debug('→ REDIRECT: The resource has moved.');
      System.debug('  Status: ' + response.getStatus());
    } else if (statusCode >= 400 && statusCode < 500) {
      // 4xx = Client Error (our fault)
      System.debug('✗ CLIENT ERROR: We made a mistake in our request.');

      if (statusCode == 400) {
        System.debug('  400 Bad Request - The data we sent was invalid');
      } else if (statusCode == 401) {
        System.debug('  401 Unauthorized - We need to log in first');
      } else if (statusCode == 403) {
        System.debug('  403 Forbidden - We\'re not allowed to access this');
      } else if (statusCode == 404) {
        System.debug('  404 Not Found - The resource doesn\'t exist');
      }
    } else if (statusCode >= 500 && statusCode < 600) {
      // 5xx = Server Error (their fault)
      System.debug('⚠ SERVER ERROR: The server is having problems.');

      if (statusCode == 500) {
        System.debug(
          '  500 Internal Server Error - Something went wrong on the server'
        );
      } else if (statusCode == 503) {
        System.debug(
          '  503 Service Unavailable - The server is temporarily down'
        );
      }
    }

    // Always log the full status for debugging
    System.debug('Full Status: ' + statusCode + ' ' + response.getStatus());
  }

  /**
   * Shows a real-world example of status code handling
   * Run: StatusCodeHandling.realWorldExample();
   */
  public static void realWorldExample() {
    System.debug('=== Real World Status Code Handling ===');

    String endpoint = 'https://jsonplaceholder.typicode.com/posts';

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json');
    request.setBody('{"title": "Test", "body": "Test post", "userId": 1}');

    try {
      HttpResponse response = http.send(request);
      Integer statusCode = response.getStatusCode();

      // Real-world handling pattern
      if (statusCode == 201) {
        // Specific handling for "Created"
        System.debug('Post created successfully!');
        System.debug('New post data: ' + response.getBody());
        // In a real app, you might parse the response and save the ID
      } else if (statusCode >= 200 && statusCode < 300) {
        // General success handling
        System.debug('Request succeeded with status: ' + statusCode);
      } else if (statusCode == 404) {
        // Handle "not found" - maybe create the resource?
        System.debug('Resource not found. Consider creating it first.');
      } else if (statusCode >= 400 && statusCode < 500) {
        // Client errors - log and fix our request
        System.debug(
          'Client error. Check your request: ' + response.getStatus()
        );
      } else if (statusCode >= 500) {
        // Server errors - maybe retry later?
        System.debug('Server error. Try again later: ' + response.getStatus());
      } else {
        // Unexpected status code
        System.debug('Unexpected status: ' + statusCode);
      }
    } catch (Exception e) {
      System.debug('Exception occurred: ' + e.getMessage());
    }
  }
}

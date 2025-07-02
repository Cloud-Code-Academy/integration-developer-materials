/**
 * ErrorHandlingExample.cls
 *
 * This class shows how to handle errors that can occur during API calls.
 * Remember: Things can go wrong! Always plan for failures.
 *
 * Common issues:
 * - Network failures
 * - API downtime
 * - Invalid endpoints
 * - Timeout errors
 * - Bad data formats
 */
public class ErrorHandlingExample {
  /**
   * Basic error handling with try-catch
   * Run: ErrorHandlingExample.basicErrorHandling();
   */
  public static void basicErrorHandling() {
    System.debug('=== Basic Error Handling ===');

    try {
      // This might fail!
      String endpoint = 'https://jsonplaceholder.typicode.com/posts/1';

      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint(endpoint);
      request.setMethod('GET');

      HttpResponse response = http.send(request);

      // Check if successful
      if (response.getStatusCode() == 200) {
        System.debug('Success! Data: ' + response.getBody());
      } else {
        System.debug('API returned error: ' + response.getStatusCode());
      }
    } catch (CalloutException e) {
      // Specific exception for callout issues
      System.debug('Callout failed: ' + e.getMessage());
    } catch (Exception e) {
      // Catch any other unexpected errors
      System.debug('Unexpected error: ' + e.getMessage());
    }
  }

  /**
   * Handling timeouts with proper settings
   * Run: ErrorHandlingExample.handleTimeouts();
   */
  public static void handleTimeouts() {
    System.debug('=== Timeout Handling ===');

    try {
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint('https://jsonplaceholder.typicode.com/posts');
      request.setMethod('GET');

      // Set a timeout (in milliseconds)
      // Default is 10 seconds, but we can change it
      request.setTimeout(5000); // 5 seconds

      System.debug('Making request with 5 second timeout...');
      HttpResponse response = http.send(request);

      System.debug('Request completed! Status: ' + response.getStatusCode());
    } catch (CalloutException e) {
      if (e.getMessage().contains('timeout')) {
        System.debug('Request timed out! The API took too long to respond.');
        System.debug('Consider: Increasing timeout or checking API health');
      } else {
        System.debug('Callout error: ' + e.getMessage());
      }
    }
  }

  /**
   * Comprehensive error handling pattern
   * Run: ErrorHandlingExample.comprehensiveHandling();
   */
  public static void comprehensiveHandling() {
    System.debug('=== Comprehensive Error Handling ===');

    String endpoint = 'https://jsonplaceholder.typicode.com/posts';
    String result = 'No result';
    Boolean success = false;

    try {
      // Validate inputs first
      if (String.isBlank(endpoint)) {
        throw new IllegalArgumentException('Endpoint cannot be empty');
      }

      // Make the callout
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint(endpoint);
      request.setMethod('GET');
      request.setTimeout(30000); // 30 seconds

      HttpResponse response = http.send(request);
      Integer statusCode = response.getStatusCode();

      // Handle different scenarios
      if (statusCode >= 200 && statusCode < 300) {
        // Success!
        result = 'Success: ' + response.getBody();
        success = true;
        System.debug('✓ API call successful');
      } else if (statusCode >= 400 && statusCode < 500) {
        // Client error - our fault
        result = 'Client Error: ' + response.getStatus();
        System.debug('✗ Client error (our fault): ' + statusCode);
        System.debug('Fix needed in our request');
      } else if (statusCode >= 500) {
        // Server error - their fault
        result = 'Server Error: ' + response.getStatus();
        System.debug('⚠ Server error (their fault): ' + statusCode);
        System.debug('Consider retrying later');
      } else {
        // Unexpected status
        result = 'Unexpected status: ' + statusCode;
        System.debug('? Unexpected status code: ' + statusCode);
      }
    } catch (CalloutException e) {
      // Network/connection issues
      result = 'Network Error: ' + e.getMessage();
      System.debug('Network/Callout error: ' + e.getMessage());
    } catch (IllegalArgumentException e) {
      // Validation errors
      result = 'Validation Error: ' + e.getMessage();
      System.debug('Input validation failed: ' + e.getMessage());
    } catch (Exception e) {
      // Unexpected errors
      result = 'Unexpected Error: ' + e.getMessage();
      System.debug('Unexpected error type: ' + e.getTypeName());
      System.debug('Error message: ' + e.getMessage());
    } finally {
      // This always runs, even if there's an error
      System.debug('Final result: ' + result);
      System.debug('Success: ' + success);
    }
  }

  /**
   * Simulates handling a completely broken endpoint
   * Run: ErrorHandlingExample.handleBrokenEndpoint();
   */
  public static void handleBrokenEndpoint() {
    System.debug('=== Handling Broken Endpoint ===');

    // Intentionally broken endpoint
    String brokenEndpoint = 'https://this-api-does-not-exist-12345.com/data';

    try {
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      request.setEndpoint(brokenEndpoint);
      request.setMethod('GET');

      System.debug('Trying broken endpoint: ' + brokenEndpoint);
      HttpResponse response = http.send(request);

      // We probably won't get here...
      System.debug('Somehow got response: ' + response.getStatusCode());
    } catch (Exception e) {
      System.debug('Expected error occurred!');
      System.debug('Error Type: ' + e.getTypeName());
      System.debug('Error Message: ' + e.getMessage());

      // In a real app, you might:
      // - Log to a custom object
      // - Send an email alert
      // - Try a backup endpoint
      // - Return a cached response

      System.debug('What to do now:');
      System.debug('- Check if the URL is correct');
      System.debug('- Verify the API is online');
      System.debug('- Check network connectivity');
      System.debug('- Contact the API provider');
    }
  }
}

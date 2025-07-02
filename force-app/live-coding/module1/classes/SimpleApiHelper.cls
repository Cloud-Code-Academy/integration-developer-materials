/**
 * SimpleApiHelper.cls
 *
 * This helper class makes API calls easier by providing reusable methods.
 * Instead of writing the same code over and over, use these helpers!
 *
 * This demonstrates the DRY principle: Don't Repeat Yourself
 */
public class SimpleApiHelper {
  // Constants for the API we're using
  private static final String BASE_URL = 'https://jsonplaceholder.typicode.com';
  private static final Integer DEFAULT_TIMEOUT = 30000; // 30 seconds

  /**
   * Makes a simple GET request and returns the response
   * Example: SimpleApiHelper.get('/posts/1');
   */
  public static HttpResponse get(String path) {
    String endpoint = BASE_URL + path;

    System.debug('GET request to: ' + endpoint);

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');
    request.setTimeout(DEFAULT_TIMEOUT);

    try {
      HttpResponse response = http.send(request);
      logResponse(response);
      return response;
    } catch (Exception e) {
      System.debug('Error in GET request: ' + e.getMessage());
      throw e;
    }
  }

  /**
   * Makes a POST request with JSON body
   * Example: SimpleApiHelper.post('/posts', '{"title":"Test"}');
   */
  public static HttpResponse post(String path, String jsonBody) {
    String endpoint = BASE_URL + path;

    System.debug('POST request to: ' + endpoint);
    System.debug('Body: ' + jsonBody);

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setBody(jsonBody);
    request.setHeader('Content-Type', 'application/json');
    request.setTimeout(DEFAULT_TIMEOUT);

    try {
      HttpResponse response = http.send(request);
      logResponse(response);
      return response;
    } catch (Exception e) {
      System.debug('Error in POST request: ' + e.getMessage());
      throw e;
    }
  }

  /**
   * Checks if a response was successful (status code 200-299)
   * Example: if (SimpleApiHelper.isSuccess(response)) { ... }
   */
  public static Boolean isSuccess(HttpResponse response) {
    Integer statusCode = response.getStatusCode();
    return statusCode >= 200 && statusCode < 300;
  }

  /**
   * Gets a friendly error message based on status code
   */
  public static String getErrorMessage(HttpResponse response) {
    Integer statusCode = response.getStatusCode();

    if (statusCode == 400) {
      return 'Bad Request - Check your data format';
    } else if (statusCode == 401) {
      return 'Unauthorized - Authentication required';
    } else if (statusCode == 403) {
      return 'Forbidden - You don\'t have permission';
    } else if (statusCode == 404) {
      return 'Not Found - The resource doesn\'t exist';
    } else if (statusCode == 500) {
      return 'Server Error - The API has a problem';
    } else if (statusCode == 503) {
      return 'Service Unavailable - API is temporarily down';
    } else if (statusCode >= 400 && statusCode < 500) {
      return 'Client Error - Problem with the request';
    } else if (statusCode >= 500) {
      return 'Server Error - Problem on the API side';
    } else {
      return 'Unexpected status: ' + statusCode;
    }
  }

  /**
   * Helper method to log response details
   */
  private static void logResponse(HttpResponse response) {
    System.debug('Status Code: ' + response.getStatusCode());
    System.debug('Status: ' + response.getStatus());

    if (isSuccess(response)) {
      System.debug('✓ Success!');
    } else {
      System.debug('✗ Error: ' + getErrorMessage(response));
    }
  }

  /**
   * Example: Using the helper methods together
   * Run: SimpleApiHelper.demonstrateUsage();
   */
  public static void demonstrateUsage() {
    System.debug('=== Using SimpleApiHelper ===');

    // Example 1: GET request
    try {
      HttpResponse getResponse = get('/posts/1');
      if (isSuccess(getResponse)) {
        System.debug('Got post: ' + getResponse.getBody());
      } else {
        System.debug('Failed: ' + getErrorMessage(getResponse));
      }
    } catch (Exception e) {
      System.debug('GET failed completely: ' + e.getMessage());
    }

    // Example 2: POST request
    try {
      String newPost = '{"title": "Helper Test", "body": "Testing helpers", "userId": 1}';
      HttpResponse postResponse = post('/posts', newPost);
      if (isSuccess(postResponse)) {
        System.debug('Created post: ' + postResponse.getBody());
      } else {
        System.debug('Failed: ' + getErrorMessage(postResponse));
      }
    } catch (Exception e) {
      System.debug('POST failed completely: ' + e.getMessage());
    }

    // Example 3: Handling 404
    try {
      HttpResponse notFoundResponse = get('/posts/999999');
      if (!isSuccess(notFoundResponse)) {
        System.debug('Expected error: ' + getErrorMessage(notFoundResponse));
      }
    } catch (Exception e) {
      System.debug('Request failed: ' + e.getMessage());
    }
  }
}

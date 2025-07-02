# Module 1: Introduction to Apex Integrations

Welcome to your first module on Apex integrations! These code examples will help you practice the concepts from our live session.

## Before You Start

1. **Set up Remote Site Settings**

   - Go to Setup → Remote Site Settings
   - Click "New Remote Site"
   - Name: `JSONPlaceholder`
   - URL: `https://jsonplaceholder.typicode.com`
   - Click "Save"

2. **Open Developer Console**
   - Click the gear icon → Developer Console
   - Open the "Execute Anonymous" window (Debug → Open Execute Anonymous Window)

## Code Examples Overview

### 1. BasicHttpGetExample.cls

Start here! This shows the simplest way to make an API call.

**Try these commands:**

```apex
// Get all posts
BasicHttpGetExample.getAllPosts();

// Get a specific post
BasicHttpGetExample.getSinglePost(1);

// Try getting a post that doesn't exist
BasicHttpGetExample.getSinglePost(999);
```

### 2. BasicHttpPostExample.cls

Learn how to send data to an API.

**Try these commands:**

```apex
// Create a simple post
BasicHttpPostExample.createSimplePost();

// Create a custom post
BasicHttpPostExample.createCustomPost('My Title', 'My content here!');

// See what happens with bad data
BasicHttpPostExample.createBadPost();
```

### 3. HttpMethodsDemo.cls

Understand the different HTTP methods (GET, POST, PUT, DELETE).

**Try these commands:**

```apex
// See each method individually
HttpMethodsDemo.demonstrateGet();
HttpMethodsDemo.demonstratePost();
HttpMethodsDemo.demonstratePut();
HttpMethodsDemo.demonstrateDelete();

// Or run all demos at once
HttpMethodsDemo.runAllDemos();
```

### 4. StatusCodeHandling.cls

Learn what different status codes mean.

**Try these commands:**

```apex
// See common status codes in action
StatusCodeHandling.handleCommonStatusCodes();

// Real-world example
StatusCodeHandling.realWorldExample();
```

### 5. ErrorHandlingExample.cls

Learn how to handle things when they go wrong (and they will!).

**Try these commands:**

```apex
// Basic error handling
ErrorHandlingExample.basicErrorHandling();

// Timeout handling
ErrorHandlingExample.handleTimeouts();

// Comprehensive pattern
ErrorHandlingExample.comprehensiveHandling();

// What happens with a broken endpoint
ErrorHandlingExample.handleBrokenEndpoint();
```

### 6. SimpleApiHelper.cls

A helper class that makes API calls easier.

**Try these commands:**

```apex
// See the helper in action
SimpleApiHelper.demonstrateUsage();

// Use the helper methods directly
HttpResponse response = SimpleApiHelper.get('/posts/1');
System.debug(response.getBody());

// Check if a response was successful
if (SimpleApiHelper.isSuccess(response)) {
    System.debug('It worked!');
}
```

## Learning Path

1. **Start with BasicHttpGetExample** - Understand the core concepts
2. **Move to BasicHttpPostExample** - Learn to send data
3. **Explore HttpMethodsDemo** - See all methods in action
4. **Study StatusCodeHandling** - Understand what responses mean
5. **Practice ErrorHandlingExample** - Learn to handle failures
6. **Use SimpleApiHelper** - See how to write reusable code

## Key Concepts to Remember

- **Http**: The main class for making HTTP requests
- **HttpRequest**: Container for your request details
- **HttpResponse**: What you get back from the API
- **Status Codes**:
  - 200-299 = Success
  - 400-499 = Client error (your fault)
  - 500-599 = Server error (their fault)

## Debugging Tips

1. Always check the Debug Log for output
2. Look for lines starting with "USER_DEBUG"
3. If you see "Unauthorized endpoint", check Remote Site Settings
4. Status code 404 means the resource doesn't exist
5. Network errors usually mean the URL is wrong or the server is down

## Next Steps

After mastering these examples:

1. Try modifying the code to call different endpoints
2. Experiment with different JSON data in POST requests
3. Practice error handling with intentionally broken requests
4. Think about how you could use these patterns in real projects

Remember: Everyone makes mistakes when learning. The debug log is your friend!

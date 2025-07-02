# Live Coding Workshop: Introduction to Apex Integrations

## Instructor Guide

### Workshop Overview

This 90-minute workshop introduces students to the fundamentals of API integrations and Salesforce development patterns. Students will learn core HTTP concepts, API documentation interpretation, and basic Apex callout implementation. The session emphasizes hands-on learning with Postman for API exploration before translating concepts into Salesforce code.

### Learning Objectives

By the end of this session, students will be able to:

- Understand fundamental HTTP request/response concepts
- Interpret API documentation and translate examples to Apex
- Use Postman effectively for API testing and exploration
- Implement basic HTTP callouts using Apex
- Configure remote site settings for external API access
- Handle different HTTP status codes and error responses
- Differentiate between HTTP methods (GET, POST, PUT, DELETE)
- Apply integration best practices from the beginning

### Session Outline (90 minutes)

#### 1. Welcome and Cohort Introductions (15 minutes)

- Welcome returning and new students to the integration cohort
- Student introductions: name, background, why they joined, fun fact
- Set expectations for the 10-week program structure
- Review course logistics: recordings, LMS access, Slack channels
- Emphasize collaborative learning and peer support

#### 2. HTTP Fundamentals and API Concepts (20 minutes)

**HTTP Methods Overview (8 minutes)**

- Explain the purpose of different HTTP request methods
- GET: Retrieving data without modification
- POST: Creating new resources or sending data
- PUT: Updating existing resources
- DELETE: Removing resources
- PATCH: Partial updates to resources
- Review when to use each method appropriately

**HTTP Status Codes (7 minutes)**

- Explain status code ranges and their meanings:
  - 1xx: Informational responses
  - 2xx: Success responses (200 OK, 201 Created)
  - 3xx: Redirection responses
  - 4xx: Client error responses (404 Not Found)
  - 5xx: Server error responses
- Emphasize that these are universal standards across all APIs
- Show how status codes guide error handling logic

**API Documentation Best Practices (5 minutes)**

- Discuss the wide variation in API documentation quality
- Explain how to identify key information: endpoints, methods, authentication
- Show examples of well-documented vs poorly-documented APIs
- Emphasize the value of Postman collections when available

#### 3. Hands-on API Exploration with Postman (25 minutes)

**Postman Setup and Basic Usage (10 minutes)**

- Demonstrate creating a new HTTP request in Postman
- Show the interface: method selection, URL field, headers, body
- Explain the different sections: Params, Authorization, Headers, Body
- Highlight the importance of environment variables for sensitive data

**Working with a Sample API (15 minutes)**

- Use JSONPlaceholder API as a safe, public testing endpoint
- Demonstrate GET request to retrieve posts data
- Show how to examine response structure and status codes
- Implement POST request with JSON body data
- Handle 404 errors to demonstrate client-side mistakes
- Explain the relationship between browser requests and Postman requests

```
Example Endpoints:
GET https://jsonplaceholder.typicode.com/posts
GET https://jsonplaceholder.typicode.com/posts/1
POST https://jsonplaceholder.typicode.com/posts

Sample POST Body:
{
  "title": "test title",
  "body": "test body content",
  "userId": 1
}
```

#### 4. Translating API Calls to Salesforce Apex (25 minutes)

**Remote Site Settings Configuration (5 minutes)**

- Explain Salesforce security model for external callouts
- Show how to navigate to Remote Site Settings in Setup
- Configure access to the demo API endpoint
- Discuss URL patterns and security considerations

**Basic Apex Callout Implementation (20 minutes)**

- Demonstrate the three core classes: `Http`, `HttpRequest`, `HttpResponse`
- Live code a simple GET request in Anonymous Apex
- Show how to set endpoint, method, and send the request
- Implement response handling with status code checking
- Add debugging to examine response body and status codes

```apex
// Basic GET Request Example
String endpoint = 'https://jsonplaceholder.typicode.com/posts';
Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint(endpoint);
request.setMethod('GET');

HttpResponse response = http.send(request);

if (response.getStatusCode() == 200) {
    System.debug('Success: ' + response.getBody());
} else {
    System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
}
```

**POST Request with Body Data (Additional 5 minutes if time permits)**

- Show how to add JSON body to POST requests
- Use `request.setBody()` to include payload data
- Handle 201 Created status codes appropriately
- Demonstrate string-based JSON construction (noting this will improve later)

```apex
// Basic POST Request Example
String endpoint = 'https://jsonplaceholder.typicode.com/posts';
String body = '{"title": "test", "body": "test content", "userId": 1}';

Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint(endpoint);
request.setMethod('POST');
request.setBody(body);

HttpResponse response = http.send(request);

if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
    System.debug('Success: ' + response.getBody());
} else if (response.getStatusCode() == 201) {
    System.debug('Created: ' + response.getBody());
} else {
    System.debug('Error: ' + response.getStatusCode());
}
```

#### 5. Integration Best Practices and Next Steps (5 minutes)

**Development Workflow Best Practices**

- Always test APIs in Postman before coding in Salesforce
- Start with simple GET requests, then progress to POST/PUT
- Use environment variables in Postman for reusability
- Check status codes for every response

**Error Handling Principles**

- Plan for network failures and API downtime
- Use status code ranges rather than specific codes when possible
- Log meaningful error information for debugging
- Consider timeout implications for long-running operations

**Preview of Upcoming Topics**

- JSON parsing and wrapper classes for cleaner code
- Authentication patterns (API keys, OAuth)
- Asynchronous callouts and governor limits
- Testing strategies with mock callouts

### Instructor Tips

**Before Class Preparation:**

- Test the JSONPlaceholder API to ensure it's accessible
- Verify Postman is installed and functional
- Prepare a backup API in case the primary one has issues
- Set up a developer org for demonstrations
- Review the cohort roster and be prepared for introductions

**During Demonstration:**

- Keep the pace accessible for beginners while engaging advanced students
- Encourage questions throughout, not just at the end
- Show real debugging workflows, including when things go wrong
- Use the VS Code debug console filtering features if available
- Emphasize that this is foundational - complexity will increase

**Common Student Challenges:**

- Understanding the difference between Postman and Salesforce environments
- Forgetting to configure remote site settings
- Confusion about when to use different HTTP methods
- JSON formatting issues in string construction
- Status code interpretation and error handling logic

**Key Points to Emphasize:**

- Integrations connect business systems and are critical for modern applications
- Start simple and build complexity gradually
- Documentation quality varies dramatically between APIs
- Testing outside Salesforce first saves significant development time
- Error handling is not optional - plan for failures
- Collaboration and peer learning accelerate understanding

**Managing the Live Session:**

- Keep introductions moving but allow personality to show
- Take screenshots for cohort documentation
- Monitor chat for questions throughout
- Be prepared to extend slightly for complex topics
- Encourage students to follow along with their own orgs

**Real-World Context:**

- Most business applications require multiple system integrations
- APIs enable data synchronization, automation, and enhanced user experiences
- Integration skills are highly valued in the Salesforce ecosystem
- The principles learned here apply to any REST API, not just Salesforce

### Homework Assignment Preview

Students should complete the first assignment focusing on:

- Postman workspace setup and basic API exploration
- Simple Apex callout implementation
- Remote site settings configuration
- Documentation review for a provided API

### Additional Resources

- Salesforce HTTP callout documentation
- HTTP status code reference
- JSON validation tools
- Postman learning resources
- Integration architecture patterns

### Copyright

Copyright © 2023-2025 Cloud Code Academy, Inc. All rights reserved.

This material is proprietary and confidential. Unauthorized use, reproduction, distribution, or modification of this material is strictly prohibited. This material is intended for educational purposes only and may not be shared, distributed, or used for commercial activities without express written permission.

For licensing inquiries or permissions, contact: admin@cloudcodeacademy.com

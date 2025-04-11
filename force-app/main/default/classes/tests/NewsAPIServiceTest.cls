@IsTest
private class NewsAPIServiceTest {
    
    @IsTest
    static void testGetTopHeadlinesByCategorySuccess() {
        // Set up the mock
        Test.setMock(HttpCalloutMock.class, NewsAPIMock.createSuccessMock());
        
        Test.startTest();
        
        // Test with valid parameters
        NewsAPIResponse response = NewsAPIService.getTopHeadlinesByCategory('technology', 20, 1);
        
        Test.stopTest();
        
        // Verify the response
        Assert.areEqual('ok', response.status, 'Response status should be ok');
        Assert.areEqual(2, response.totalResults, 'Should have 2 articles');
        Assert.areEqual(2, response.articles.size(), 'Should have 2 articles');
    }
    
    @IsTest
    static void testGetTopHeadlinesByCategoryWithInvalidParameters() {
        // Set up the mock
        Test.setMock(HttpCalloutMock.class, NewsAPIMock.createSuccessMock());
        
        Test.startTest();
        
        // Test with invalid page size (should use default)
        NewsAPIResponse response = NewsAPIService.getTopHeadlinesByCategory('technology', 0, 1);
        
        Test.stopTest();
        
        // Verify the response
        Assert.areEqual('ok', response.status, 'Response status should be ok');
        Assert.areEqual(2, response.totalResults, 'Should have 2 articles');
    }
} 
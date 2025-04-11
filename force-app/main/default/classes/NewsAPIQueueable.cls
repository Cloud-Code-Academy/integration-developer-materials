public with sharing class NewsAPIQueueable implements Queueable, Database.AllowsCallouts {

    private News_Category__c category;
    private Integer currentPage;

    private static final Integer MAX_PAGES = 2; // Maximum number of pages to process
    
    public NewsAPIQueueable(News_Category__c category, Integer currentPage) {
        this.category = category;
        this.currentPage = currentPage;
    }


    public void execute(QueueableContext context) {
        System.debug('Executing NewsAPIQueueable...' + category.Name + ' page: ' + currentPage);
        String responseBody = NewsAPIService.getTopHeadlines(category.Name, currentPage);

       
        NewsAPIResponse newsResponse = NewsAPIResponse.parse(responseBody);
        NewsAPIResponse.insertArticleFromResponse(newsResponse.articles);

        if (currentPage < MAX_PAGES) {
            if (!Test.isRunningTest()) {
                NewsAPIQueueable job = new NewsAPIQueueable(category, currentPage + 1);
                System.enqueueJob(job);
            }
        } else {
            // Update the category to set Sync__c to false and set Last_Synced__c to now
            News_Category__c tempCategory = new News_Category__c(Id = category.Id);
            tempCategory.Sync__c = false;
            tempCategory.Last_Synced__c = System.now();
            update tempCategory;
            // category.Sync__c = false;
            // update category;
        }
    }
}
public with sharing class NewsCategoryTriggerHandler {
    // public static void onAfterInsertFuture(List<News_Category__c> newCategories) {
    //     for (News_Category__c newsCategory : newCategories) {
    //         NewsAPIService.getTopHeadlinesFuture(newsCategory.Name);
    //     }
    // }

    public static void onAfterInsertQueueable(List<News_Category__c> newCategories) {
        for (News_Category__c newsCategory : newCategories) {
            System.enqueueJob(new NewsAPIQueueable(1));
        }
    }
}
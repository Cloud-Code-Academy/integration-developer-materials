public with sharing class NewsCategoryTriggerHandler {
    public static void onAfterInsert(List<News_Category__c> newCategories) {
        for (News_Category__c newsCategory : newCategories) {
            NewsAPIService.getTopHeadlines(newsCategory.Name);
        }
    }
}
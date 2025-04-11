public with sharing class NewsCategoryTriggerHandler {

    private static List<News_Category__c> categoriesToUpdate = new List<News_Category__c>();
    public static void handleInsert(List<News_Category__c> newCategories) {
        for (News_Category__c newsCategory : newCategories) {
            if (newsCategory.Sync__c == true) {
                categoriesToUpdate.add(newsCategory);
            }
        }

        if (!categoriesToUpdate.isEmpty()) {
            // Enqueue the job for each category
            enqueueJob(categoriesToUpdate);
        }
    }

    public static void handleUpdate(List<News_Category__c> newCategories) {

        for (News_Category__c newsCategory : newCategories) {
            if (newsCategory.Sync__c == true) {
                categoriesToUpdate.add(newsCategory);
            }
        }

        if (!categoriesToUpdate.isEmpty()) {
            // Enqueue the job for each category
            enqueueJob(categoriesToUpdate);
        }


    }

    private static void enqueueJob(News_Category__c[] newsCategory) {
        for (News_Category__c category : newsCategory) {
            // Enqueue the job for each category
            if (!Test.isRunningTest()){
                NewsAPIQueueable job = new NewsAPIQueueable(category, 1);
                System.enqueueJob(job);
            }
        }   
    }
}
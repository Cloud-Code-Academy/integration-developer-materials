trigger NewsCategoryTrigger on News_Category__c (after insert, after update) {

    if(Trigger.isAfter && Trigger.isInsert){
        NewsCategoryTriggerHandler.onAfterInsert(Trigger.new);
    }
}
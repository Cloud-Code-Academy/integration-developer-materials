trigger NewsCategoryTrigger on News_Category__c (after insert, after update) {

    if(Trigger.isAfter && Trigger.isInsert){
        NewsCategoryTriggerHandler.handleInsert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        NewsCategoryTriggerHandler.handleUpdate(Trigger.new);
    }
}
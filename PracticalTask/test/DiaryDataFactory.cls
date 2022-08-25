@IsTest
public with sharing class DiaryDataFactory {

    public static Contact createContact(){
        return new Contact(LastName = 'Test');
    }

    public static List<Diary__c> createDiariesByContactId(Integer amountOfDiaries, Id contactId) {

        List<Diary__c> diaries = new List<Diary__c>();

        for (Integer i = 0; i < amountOfDiaries; i++) {
            diaries.add(new Diary__c(Contact__c = contactId));
        }
        return diaries;
    }



}
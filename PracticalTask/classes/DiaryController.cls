public with sharing class DiaryController {

    @AuraEnabled(Cacheable=true)
    public static List<Diary__c> getDiaryNotesByContactId(Id contactId) {
        return [
                SELECT CreatedDate, Note__c
                FROM Diary__c
                WHERE Contact__c = :contactId
                WITH SECURITY_ENFORCED
                LIMIT 5  //so that the whole page is not occupied if there are a lot of notes
        ];
    }

    @AuraEnabled
    public static void createNewDiaryRelated(Id contactId, String note) {
        insert new Diary__c(Contact__c = contactId, Note__c = note);
    }
}
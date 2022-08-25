@IsTest
public class DiaryTest {

    @IsTest
    static void getDiaryNotesByContactIdTest(){

        Contact cont = DiaryDataFactory.createContact();
        insert cont;

        Diary__c diary = new Diary__c(Contact__c = cont.Id);
        insert diary;

        Test.startTest();
            List <Diary__c> diaries = DiaryController.getDiaryNotesByContactId(cont.Id);
        Test.stopTest();

        System.assertEquals(1, diaries.size());

    }

    @IsTest
    static void getDiaryNotesByContactIdTestBulk(){

        Contact cont = DiaryDataFactory.createContact();
        insert cont;

        List<Diary__c> diaries = DiaryDataFactory.createDiariesByContactId(200, cont.Id);
        insert diaries;

        Test.startTest();
            List <Diary__c> listDiaries = DiaryController.getDiaryNotesByContactId(cont.Id);
        Test.stopTest();

        System.assertEquals(200, listDiaries.size());

    }

    @IsTest
    static void createNewDiaryRelatedTest(){

        Contact cont = DiaryDataFactory.createContact();
        insert cont;

        Test.startTest();
            DiaryController.createNewDiaryRelated(cont.Id, 'Some note');
        Test.stopTest();

        Diary__c diary = [SELECT Note__c FROM Diary__c WHERE Contact__c =: cont.Id];

        System.assertEquals(diary.Note__c, 'Some note');

    }
}
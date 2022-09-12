@IsTest
private with sharing class ChangeAccountNamesBatchTest {

    @TestSetup
    public static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            accounts.add(new Account(Name = 'Test'));
        }
        insert accounts;
    }

    @IsTest
    public static void testChangeAccountNamesBatch() {

        Test.startTest();
            ChangeAccountNamesBatch changeAccountNamesBatch = new ChangeAccountNamesBatch();
            Id batchId = Database.executeBatch(changeAccountNamesBatch);
        Test.stopTest();

        System.assertEquals(200, [SELECT COUNT() FROM Account WHERE Name = 'Test Batch Processed']);

    }

}
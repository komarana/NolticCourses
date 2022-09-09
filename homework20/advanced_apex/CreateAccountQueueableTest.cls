@IsTest
private with sharing class CreateAccountQueueableTest {

    @IsTest
    public static void testCreateAccountQueueable() {
        String name = 'Test Name';

        Test.startTest();
            System.enqueueJob(new CreateAccountQueueable(name));
        Test.stopTest();

        Account testAccount = [SELECT Name FROM Account WHERE Name =: name];
        System.assertNotEquals(null, testAccount);
        System.assertEquals('Test Name', testAccount.Name);

    }

}
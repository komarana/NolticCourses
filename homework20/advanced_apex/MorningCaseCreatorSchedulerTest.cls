@IsTest
private with sharing class MorningCaseCreatorSchedulerTest {

    @IsTest
    public static void testMorningCaseCreatorScheduler() {

        Test.startTest();

        String jobId = System.schedule(
                'Create Morning Case', MorningCaseCreatorScheduler.expression,
                new MorningCaseCreatorScheduler()
        );

        CronTrigger ct = [
                SELECT Id, CronExpression, NextFireTime
                FROM CronTrigger
                WHERE Id =:jobId
        ];

        Test.stopTest();

        System.assertEquals(MorningCaseCreatorScheduler.expression, ct.CronExpression);
        System.assertEquals('2022-09-10 07:00:00', String.valueOf(ct.NextFireTime));

    }

}
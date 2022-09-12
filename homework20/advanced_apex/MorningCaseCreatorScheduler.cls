public with sharing class MorningCaseCreatorScheduler implements Schedulable {

   public static String expression = '0 0 7 1/1 * ? *';

   public void execute(SchedulableContext sc) {

        CronTrigger ct = [
                SELECT Id, CronExpression
                FROM CronTrigger
                WHERE Id =: sc.getTriggerId()
        ];

        System.assertEquals(expression, ct.CronExpression);

        Datetime todayDate = System.today();
        Case c = new Case(Subject = 'Morning Case - ' + todayDate.format('dd-MM-yyyy'));
        insert c;
    }

}

//System.schedule('Create Morning Case', MorningCaseCreatorScheduler.expression, new MorningCaseCreatorScheduler());
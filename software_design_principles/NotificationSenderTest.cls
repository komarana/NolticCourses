@IsTest
public class NotificationSenderTest {

    @IsTest
    static void sendNotification_ObjectNotificationSender(){

        NotificationSender notificationSender;
        notificationSender = new ObjectNotificationSender();

        String notificationMessage = 'Hello';

        Test.startTest();
            notificationSender.sendNotification(notificationMessage);
        Test.stopTest();

        Notification__c notification = [
                SELECT Notification_Message__c
                FROM Notification__c
        ];
        System.assertEquals(notification.Notification_Message__c, 'Hello');

    }

    @IsTest
    static void sendNotification_EmailNotificationSender(){

        NotificationSender notificationSender;
        notificationSender = new EmailNotificationSender();

        Test.startTest();
            notificationSender.sendNotification('Hello Test');
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.assertEquals(1, invocations, 'Hello Test');

    }

    @IsTest
    static void notificationSenderService_initNotificationSender(){

        NotificationSenderService notificationSenderService = new NotificationSenderService();
        NotificationSender notificationSender = new ObjectNotificationSender();

        String message = 'Hello World';

        Test.startTest();
            notificationSenderService.initNotificationSender(notificationSender, message);
        Test.stopTest();


        List<Notification__c> notification = [
                SELECT Notification_Message__c
                FROM Notification__c
        ];

        System.assertEquals(notification[0].Notification_Message__c, message);
    }

    @IsTest
    static void notificationSenderService_executeSend(){

        NotificationSenderService notificationSenderService = new NotificationSenderService();

        Test.startTest();
            notificationSenderService.executeSend();
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.assertEquals(1, invocations);
    }
}
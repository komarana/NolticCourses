public with sharing class ObjectNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage) {

        Notification__c notification = new Notification__c(Notification_Message__c = notificationMessage);
        insert notification;
    }
}
public with sharing class EmailNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage) {

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{UserInfo.getUserEmail()};

        message.setToAddresses(toAddresses);
        message.setPlainTextBody(notificationMessage);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });

    }
}
public with sharing class NotificationSenderService {
    NotificationSender notificationSender;
    String emailMessage;

    public void initNotificationSender(NotificationSender sender, String message) {

        emailMessage = message;

        notificationSender = new ObjectNotificationSender();
        notificationSender.sendNotification(emailMessage);

    }

    public void executeSend() {

        notificationSender = new EmailNotificationSender();
        notificationSender.sendNotification(emailMessage);

    }
}
public with sharing class NotificationSenderService {
    private NotificationSender notificationSender {get; set;}
    private String emailMessage {get; set;}


    public void initNotificationSender(NotificationSender sender, String message) {

        emailMessage = message;
        notificationSender = sender;

    }

    public void executeSend() {

        notificationSender.sendNotification(emailMessage);

    }
}
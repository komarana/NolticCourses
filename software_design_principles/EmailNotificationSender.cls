public with sharing class EmailNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage) {

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{UserInfo.getUserEmail()};

        message.setToAddresses(toAddresses);
        message.setPlainTextBody(notificationMessage);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });

        Map<String,System.OrgLimit> limitsMap = OrgLimits.getMap();
        System.OrgLimit apiRequestsLimit = limitsMap.get('SingleEmail');
        System.debug('Limit Name: ' + apiRequestsLimit.getName());
        System.debug('Usage Value: ' + apiRequestsLimit.getValue());
        System.debug('Maximum Limit: ' + apiRequestsLimit.getLimit());

    }
}
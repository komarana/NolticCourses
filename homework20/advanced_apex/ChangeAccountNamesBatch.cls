public with sharing class ChangeAccountNamesBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Name FROM Account');
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {

        for (Account accItem : scope) {
            if (!accItem.Name.contains('Batch Processed')) { //з Set(Id) не вийшло, кожного разу транзакція обнуляється
                accItem.Name = accItem.Name + ' Batch Processed';
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {

        AsyncApexJob asyncApexJob = [
                SELECT Id, Status, NumberOfErrors, TotalJobItems
                FROM AsyncApexJob
                WHERE Id = :bc.getJobId()
        ];

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{UserInfo.getUserEmail()};

        message.setToAddresses(toAddresses);
        message.setSubject('Apex Sharing Recalculation ' + asyncApexJob.Status);
        message.setPlainTextBody('The batch Apex job processed ' + asyncApexJob.TotalJobItems +
                                ' batches with ' + asyncApexJob.NumberOfErrors + ' failures. Total processed ' +
                                recordsProcessed + ' records.');

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
    }

}

//Id batchId = Database.executeBatch(new ChangeAccountNamesBatch());


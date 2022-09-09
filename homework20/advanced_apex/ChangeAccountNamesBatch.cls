public with sharing class ChangeAccountNamesBatch implements Database.Batchable<SObject>, Database.Stateful {
    private final String q;
    public Integer recordsProcessed = 0;

    public ChangeAccountNamesBatch(String query) {
        q = query;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(q);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account accItem : scope){
            accItem.Name = accItem.Name + ' Batch Processed';
            accountsToUpdate.add(accItem);
            recordsProcessed = recordsProcessed + 1;
        }
        update accountsToUpdate;
    }

    public void finish(Database.BatchableContext bc) {
        AsyncApexJob asyncApexJob = [
                SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems
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

//Id batchId = Database.executeBatch(new ChangeAccountNamesBatch('SELECT Name FROM Account'));
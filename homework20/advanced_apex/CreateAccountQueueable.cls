public with sharing class CreateAccountQueueable implements Queueable {
    private String name;

    public CreateAccountQueueable(String accountName) {
        this.name = accountName;
    }

    public void execute(QueueableContext qc) {
        Account account = new Account(Name = name);
        insert account;
    }
}

//ID jobID = System.enqueueJob(new CreateAccountQueueable('Test'));
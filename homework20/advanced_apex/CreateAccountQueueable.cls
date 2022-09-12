public with sharing class CreateAccountQueueable implements Queueable {
    private String name;

    public CreateAccountQueueable(String accountName) {
        this.name = accountName;
    }

    public void execute(QueueableContext qc) {
        insert new Account(Name = name);
    }
}

//ID jobID = System.enqueueJob(new CreateAccountQueueable('Test'));
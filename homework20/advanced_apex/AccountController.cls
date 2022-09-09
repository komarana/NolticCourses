public with sharing class AccountController {

    @Future
    public static void createAccountFuture(String accountName) {

        Account account = new Account(Name = accountName);
        insert account;

    }
}
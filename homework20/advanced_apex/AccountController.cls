public with sharing class AccountController {

    @Future
    public static void createAccountFuture(String accountName) {
        insert new Account(Name = accountName);

    }
}
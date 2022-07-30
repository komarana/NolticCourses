@IsTest
private class CaseTest {

    @IsTest
    static void testUpdateAmountClosedCases_UpdateSuccessMessage() {

        Country__c testCountry = CaseDataFactory.createCountry();
        insert testCountry;
        List<Case> caseList = CaseDataFactory.createCasesWithCountry(5, testCountry.Id);
        insert caseList;

        for (Case c : caseList) {
            c.Status = 'Closed';
        }

        Test.startTest();
            update caseList;
        Test.stopTest();

        System.assertEquals(testCountry.ClosedCases__c, null);

        List<Case> cases = [SELECT Id, SuccessMessage__c FROM Case WHERE Status = 'Closed'];
        System.assertEquals(5, cases.size());

        Country__c country = [SELECT Id, ClosedCases__c, SuccessMessage__c FROM Country__c WHERE Id = :testCountry.Id];
        System.assertEquals(country.ClosedCases__c, 5);
        System.assert(country.SuccessMessage__c == cases[0].SuccessMessage__c);
    }

    @IsTest
    static void testUpdateAmountClosedCasesOnCountry_WhenDeleteCase() {

        Country__c testCountry = CaseDataFactory.createCountry();
        insert testCountry;
        List<Case> caseList = CaseDataFactory.createCasesWithCountryCaseClosed(5, testCountry.Id);
        insert caseList;

        List<Case> caseList2 = [SELECT Id FROM Case WHERE Status = 'Closed' LIMIT 2];

        Test.startTest();
            delete caseList2;
        Test.stopTest();

        Country__c country = [SELECT Id, ClosedCases__c FROM Country__c WHERE Id = :testCountry.Id];
        System.assertEquals(country.ClosedCases__c, 3);
    }
}
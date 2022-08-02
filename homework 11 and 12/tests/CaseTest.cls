@IsTest
public class CaseTest {

    @IsTest
    static void testUpdateAmountClosedCases() {

        Country__c testCountry = CaseDataFactory.createCountry();
        insert testCountry;
        List<Case> caseList = CaseDataFactory.createCasesWithCountry(200, testCountry.Id);
        insert caseList;

        Test.startTest();
            for (Case c : caseList) {
                c.Status = 'Closed';
            }
            update caseList;
        Test.stopTest();

        System.assertEquals(testCountry.ClosedCases__c, null);

        List<Case> cases = [SELECT Id, SuccessMessage__c FROM Case WHERE Status = 'Closed'];
        System.assertEquals(200, cases.size());

        Country__c country = [SELECT Id, ClosedCases__c FROM Country__c WHERE Id = :testCountry.Id];
        System.assert(country.ClosedCases__c == cases.size());
    }

    @IsTest
    static void testUpdateSuccessMessageCases() {

        Country__c testCountry = CaseDataFactory.createCountry();
        insert testCountry;
        Case testCase = CaseDataFactory.createCase();
        insert testCase;

        Test.startTest();
            testCase.Status = 'Closed';
            testCase.Country__c = testCountry.Id;
            update testCase;
        Test.stopTest();

        System.assertEquals(testCountry.ClosedCases__c, null);

        Country__c country = [SELECT Id, ClosedCases__c, SuccessMessage__c FROM Country__c];
        Case testCase2 = [SELECT Id, SuccessMessage__c FROM Case WHERE Country__c =: country.Id];

        System.assertEquals(country.ClosedCases__c, 1);
        System.assert(country.SuccessMessage__c == testCase2.SuccessMessage__c);
    }

    @IsTest
    static void testUpdateAmountClosedCasesOnCountry_WhenDeleteCase() {

        Country__c testCountry = CaseDataFactory.createCountry();
        insert testCountry;
        List<Case> caseList = CaseDataFactory.createCasesWithCountry(200, testCountry.Id);
        insert caseList;
        for (Case c : caseList) {
            c.Status = 'Closed';
        }
        update caseList;

        Test.startTest();
            List<Case> caseList2 = [SELECT Id FROM Case WHERE Status = 'Closed' LIMIT 50];
            delete caseList2;
        Test.stopTest();

        List<Case> caseList3 = [SELECT Id FROM Case];
        System.assertEquals(150, caseList3.size());

        Country__c country = [SELECT Id, ClosedCases__c FROM Country__c WHERE Id = :testCountry.Id];
        System.assertEquals(country.ClosedCases__c, 150);
    }
}
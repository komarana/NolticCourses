@IsTest
public class CaseDataFactory {

    public static List<Case> createCasesWithCountry(Integer caseCount, Id countryId) {

        List<Case> cases = new List<Case>();

        for (Integer i = 0; i < caseCount; i++) {
            cases.add(new Case(Country__c = countryId));
        }
        return cases;
    }

    public static Country__c createCountry() {
        return new Country__c(Name = 'Test Country');
    }

    public static Case createCase() {
        return new Case(Status = 'New', Origin = 'Phone');
    }
}

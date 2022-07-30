@IsTest
public class CaseDataFactory {

    public static List<Case> createCasesWithCountry(Integer caseCount, Id countryId) {

        List<Case> cases = new List<Case>();

        for (Integer i = 0; i < caseCount; i++) {
            cases.add(new Case(Country__c = countryId));
        }
        return cases;
    }

    public static List<Case> createCasesWithCountryCaseClosed(Integer caseCount, Id countryId) {

        List<Case> cases = new List<Case>();

        for (Integer i = 0; i < caseCount; i++) {
            cases.add(new Case(Status = 'Closed', Country__c = countryId));
        }
        return cases;
    }

    public static Country__c createCountry() {
        return new Country__c(Name = 'Test Country');
    }
}

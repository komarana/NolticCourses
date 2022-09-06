@IsTest
public class HomeworkRestServiceTest {

    @TestSetup
    static void dataSetup() {
        Contact contact = new Contact(LastName = 'Test');
        insert contact;
    }

    @IsTest
    static void testGetPositiveId() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        RestContext.request = req;
        RestContext.response = res;

        Contact contact = [SELECT Name, Phone, Email FROM Contact LIMIT 1];

        String query = contact.Id;

        RestContext.request.requestURI = '/services/apexrest/contact/' + query;

        Test.startTest();
            HomeworkRestService.getContactsByQuery();
        Test.stopTest();

        String actual = res.responseBody.toString();
        String expected = '{"name" : "name", "phone" : "phone", "email" : "email"}';
        System.assertEquals(actual, expected);
        System.assertEquals(200, res.statusCode);


    }

    @IsTest
    static void testGetPositiveQuery() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        RestContext.request = req;
        RestContext.response = res;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 10; i++) {
            contacts.add(new Contact(LastName = 'Komar' + i));
        }

        String query = 'Komar';

        RestContext.request.requestURI = '/services/apexrest/contact/' + query;

        Test.startTest();
        List<List<SObject>> result = HomeworkRestService.getContactsByQuery();
        Test.stopTest();

        String actual = res.responseBody.toString();
        String expected = '{"lastName" : "Komar", "phone" : "phone", "email" : "email"}';

        System.assertEquals(actual, expected);
        System.assertEquals(10, result.size());
        System.assertEquals(200, res.statusCode);

    }

    @IsTest
    static void testGetNegative() {

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        RestContext.request = req;
        RestContext.response = res;

        String query = '00hgjmg000nkjlh';

        RestContext.request.requestURI = '/services/apexrest/contact/' + query;
        Boolean testException = false;

        Test.startTest();
        try {
            HomeworkRestService.getContactsByQuery();
        } catch (Exception ex) {
            testException = true;
        }
        Test.stopTest();

        System.assert(!testException);

    }

}
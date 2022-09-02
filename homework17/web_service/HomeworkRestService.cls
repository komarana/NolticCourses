@RestResource(UrlMapping='/contact/*')
global with sharing class HomeworkRestService {

// отримую задану кількість рекордів

    /*   @HttpGet
    global static List<Contact> getContactsByLimit() {

        RestRequest cRequest = RestContext.request;
        String contactRequestURI = cRequest.requestURI;

        Integer contactLimit = Integer.valueOf(contactRequestURI.substring(cRequestURI.lastIndexOf('/') + 1));

        List<Contact> contacts = [
                SELECT Id, Name, Phone, Email
                FROM Contact
                LIMIT : contactLimit
        ];

        return contacts;
    } */

// отримую рекорд по id та по sosl запиту

    private class CustomException extends Exception {
    }

    @HttpGet
    global static List<List<SObject>> getContactsByQuery() {

        String query = RestContext.request.requestURI.substringAfterLast('/');

        try {
            if (query instanceof Id) {
                Contact record = [
                        SELECT Name, Phone, Email
                        FROM Contact
                        WHERE Id = :query
                ];
                return new List<List<SObject>>{
                        new List<SObject>{
                                record
                        }
                };

            }
            return [FIND :query IN ALL FIELDS RETURNING Contact(Id, Name, Phone, Email)];


        } catch (Exception ex) {
            throw new CustomException(ex.getMessage());
        }
    }


    @HttpPost
    global static String postContact(String lastName, String phone, String email) {

        try {
            Contact contact = new Contact(
                    LastName = lastName,
                    Phone = phone,
                    Email = email
            );

            insert contact;
            return contact.Id;

        } catch (Exception ex) {
            throw new CustomException(ex.getMessage());
        }
    }

    @HttpPatch
    global static Contact patchContactById() {

        String contactId = RestContext.request.requestURI.substringAfterLast('/');
        String requestBody = RestContext.request.requestBody.toString();

        Contact updateContact;

        try {
            if (String.isNotEmpty(contactId)) {
                updateContact = (Contact) JSON.deserialize(requestBody, Contact.class);
                updateContact.Id = contactId;

                update updateContact;
            }
            return updateContact;

        } catch (Exception ex) {
            throw new CustomException(ex.getMessage());
        }
    }

    @HttpDelete
    global static Contact deleteContactById() {

        String contactId = RestContext.request.requestURI.substringAfterLast('/');

        try {
            Contact deleteContact = [
                    SELECT Id, Name, Phone, Email
                    FROM Contact
                    WHERE Id = :contactId
            ];
            delete deleteContact;
            return deleteContact;

        } catch (Exception ex) {
            throw new CustomException(ex.getMessage());
        }
    }
}
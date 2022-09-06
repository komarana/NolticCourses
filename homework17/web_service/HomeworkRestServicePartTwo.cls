@RestResource(UrlMapping='/contact')
global with sharing class HomeworkRestServicePartTwo {

// в цьому методі я намагалася отримати рекорди по id та певну кількість рекордів

    public class EndpointTypeDTO {

        public String name { get; set; }
        public Integer count { get; set; }

    }

    public static String contactId = '';
    public static Integer contactAll = null;

    @HttpGet
    global static void getContact() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        EndpointTypeDTO type;

        try {
            type = (EndpointTypeDTO) JSON.deserialize(req.requestBody.toString(), EndpointTypeDTO.class);

            if (type.name == contactId) {
                contactId = String.valueOf(RestContext.request.requestURI.substringAfterLast('/'));

                res.headers.put('Content-Type', 'application/json');
                res.responseBody = Blob.valueOf(JSON.serializePretty([
                        SELECT Id, Name
                        FROM Account
                        WHERE Id = :contactId
                ]));

            } else if (type.count == contactAll) {
                contactAll = Integer.valueOf(RestContext.request.requestURI.substringAfterLast('/'));
                res.headers.put('Content-Type', 'application/json');
                res.responseBody = Blob.valueOf(JSON.serializePretty([
                        SELECT Id, Name
                        FROM Account
                        LIMIT :contactAll
                ]));

            }
        } catch (JSONException e) {
            setExceptionResponse(e);
        }
    }

    private static void setExceptionResponse(Exception e) {
        RestContext.response.responseBody = Blob.valueOf('{ "message" : "' + e + '"}');
        RestContext.response.statusCode = 500;
    }
}
public with sharing class NewsAPIService {

    public static String getTopHeadlines(String category, Integer page){
        String namedCred = 'callout:NewsAPI'; // https://newsapi.org
        String urlParth = '/v2/top-headlines?category='+ category + '&page=' + page;
        String endpoint = namedCred + urlParth;
        String responseBody = makeCallout(endpoint);
        return responseBody;
    }


    public static String makeCallout(String endpoint){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        return res.getBody();


    }
}
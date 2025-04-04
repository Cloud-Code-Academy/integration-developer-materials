public with sharing class NewsAPIService {


    // @future(callout=true)
    // public static void getTopHeadlinesFuture(List<Id> categoryIds){
    //     getTopHeadlines(categoryIds);
    // }

    public static void getTopHeadlines(List<Id> categoryIds, Integer page){
        List<Category__c> categories = [SELECT Name FROM Category__c WHERE Id IN :categoryIds];
        String namedCred = 'callout:NewsAPI'; // https://newsapi.org
        String urlParth = '/v2/top-headlines?category='+ category + '&page=' + page;
        String endpoint = namedCred + urlParth;
        makeCallout(endpoint);
    }


    public static void makeCallout(String endpoint){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        NewsAPIResponse newsResponse = NewsAPIResponse.parse(res.getBody());
        NewsAPIResponse.Article[] articlesWrappers = newsResponse.articles;
        NewsAPIResponse.insertArticleFromResponse(articles);


        for (NewsAPIResponse.Article article : articlesWrappers) {
            String jsonArticle = JSON.serialize(article);
        }


    }
}
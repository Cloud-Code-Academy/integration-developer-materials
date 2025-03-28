public with sharing class NewsAPIResponse {
    public class Source {
        public String id;
        public String name;
    }

    public class Article {
        public Source source;
        public String author;
        public String title;
        public String description;
        public String url;
        public String urlToImage;
        public String publishedAt;
        public String content;
    }

    public String status;
    public Integer totalResults;
    public List<Article> articles;

    public static NewsAPIResponse parse(String json) {
        return (NewsAPIResponse) System.JSON.deserialize(json, NewsAPIResponse.class);
    }

    public static NewsAPIResponse parseUntyped(String json) {
        Map<String,Object> tempObject = (Map<String,Object>)System.JSON.deserializeUntyped(json);
        NewsAPIResponse response = new NewsAPIResponse();
        response.status = (String)tempObject.get('status');
        response.totalResults = (Integer)tempObject.get('totalResults');
        response.articles = new List<Article>();
        List<Object> articles = (List<Object>)tempObject.get('articles');
        for(Object article : articles) {
            Map<String,Object> articleMap = (Map<String,Object>)article;
            Article articleObj = new Article();
            // articleObj.source = (Map<String,Object>)articleMap.get('source');
            articleObj.author = (String)articleMap.get('author');
            articleObj.title = (String)articleMap.get('title');
            articleObj.description = (String)articleMap.get('description');
            articleObj.url = (String)articleMap.get('url');
        }
        return response;
    }


    public static void insertArticleFromResponse(NewsAPIResponse.Article[] articles) {
        List<Article__c> articlesToInsert = new List<Article__c>();
        for (NewsAPIResponse.Article article : articles) {
            Article__c a = new Article__c();
            a.Author__c = article.author;   
            a.Title__c = article.title;
            a.Description__c = article.description;
            a.Url__c = article.url;
            a.UrlToImage__c = article.urlToImage != null && article.urlToImage.length() > 255 ? article.urlToImage.substring(0,255) : article.urlToImage;
            // Long lastUpdateLongValue = Long.valueOf(article.publishedAt) * 1000;
            // Datetime lastUpdated = Datetime.newInstance(lastUpdateLongValue);
            // a.Published_At__c = lastUpdated;
            a.Content__c = article.content;
            articlesToInsert.add(a);
        }
        insert articlesToInsert;
    }

}
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
        public DateTime publishedAt;
        public String content;

        public Article__c toSObject() {
            Article__c article = new Article__c();
            article.Author__c = this.author;
            article.Title__c = this.title;
            article.Description__c = this.description;
            article.Url__c = this.url;
            article.UrlToImage__c = this.urlToImage != null && this.urlToImage.length() > 255 ? this.urlToImage.substring(0, 255) : this.urlToImage;
            // Long lastUpdateLongValue = Long.valueOf(this.publishedAt) * 1000;
            // Datetime lastUpdated = Datetime.newInstance(lastUpdateLongValue);
            article.Published_At__c = this.publishedAt;
            article.Content__c = this.content;
    
            return article;
        }
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
        for (NewsAPIResponse.Article articleWrap : articles) {
            Article__c a = articleWrap.toSObject();
            articlesToInsert.add(a);
        }
        insert articlesToInsert;
    }

    // private static Article__c generateArticleFromWrapper(NewsAPIResponse.Article articleWrap) {
    //     Article__c a = articleWrap.toSObject();
    //     return a;
    // }

    private static Article__c generateArticleFromWrapper(NewsAPIResponse.Article articleWrap) {
        Article__c a = new Article__c();
        a.Author__c = articleWrap.author;
        a.Title__c = articleWrap.title;
        a.Description__c = articleWrap.description;
        a.Url__c = articleWrap.url;
        a.UrlToImage__c = articleWrap.urlToImage != null && articleWrap.urlToImage.length() > 255 ? articleWrap.urlToImage.substring(0, 255) : articleWrap.urlToImage;
        // Long lastUpdateLongValue = Long.valueOf(articleWrap.publishedAt) * 1000;
        // Datetime lastUpdated = Datetime.newInstance(lastUpdateLongValue);
        // a.Published_At__c = lastUpdated;
        a.Content__c = articleWrap.content;
        // a.Category__c = category;
        return a;
    }

}
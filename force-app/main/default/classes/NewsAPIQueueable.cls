public with sharing class NewsAPIQueueable implements Queueable, Database.AllowsCallouts {

    private Integer page;

    public NewsAPIQueueable() {
        this.page = 1;
    }

    public NewsAPIQueueable(Integer page) {
        this.page = page;
    }

    public void execute(QueueableContext context) {
        System.debug('Executing NewsAPIQueueable...');
        // NewsAPIService.getTopHeadlines(page);
        System.debug('Page: ' + page);

        //what page am I on
        //how many pages do I have
        //Run a calculation to get the last page
        //Am I on the last page

        //if I am not on the last page, enqueue the next job
        if (page < 5) {
            NewsAPIQueueable nextJob = new NewsAPIQueueable(page + 1);
            System.debug('Enqueuing next job with page: ' + nextJob.page);
            System.enqueueJob(nextJob);
        } else {
            System.debug('Reached maximum page limit. No more jobs will be enqueued.');
        }
    }
}
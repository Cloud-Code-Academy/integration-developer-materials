public with sharing class ExchangeRateService {

    private static final String BASE_CURRENCY = 'USD';


    public static void makeCallout() {
        HttpRequest request = new HttpRequest();

        // exchangerate.com /apikey/latest/USD
        request.setEndpoint('callout:ExchangeRate_API' + '/latest/'+ BASE_CURRENCY);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug('Response: ' + response.getBody());

            ExchangeRate exRate = (ExchangeRate) JSON.deserialize(response.getBody(), ExchangeRate.class);
            System.debug(exRate);
            System.debug(exRate.result);
            for (String key : exRate.conversion_rates.keySet()) {
                System.debug(key + ' : ' + exRate.conversion_rates.get(key));
            }
        } else {
            System.debug('Callout failed: ' + response);
        }
    }

}
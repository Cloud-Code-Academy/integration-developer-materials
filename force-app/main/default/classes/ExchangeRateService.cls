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

            ExchangeRateWrapper exRate = (ExchangeRateWrapper) JSON.deserialize(response.getBody(), ExchangeRateWrapper.class);
            System.debug(exRate);
            System.debug(exRate.result);
            for (String key : exRate.conversion_rates.keySet()) {
                System.debug(key + ' : ' + exRate.conversion_rates.get(key));
            }
        } else {
            System.debug('Callout failed: ' + response);
        }
    }

    class ExchangeRateWrapper {
        public String result;
        public String documentation;
        public String terms_of_use;
        public Map<String,Decimal> conversion_rates;
        public String myCurrency;

        
    }

    public static ExchangeRateWrapper parse(String jsonResponse) {
        
        // Use JSON.deserialize to parse the response
        ExchangeRateWrapper wrapper = (ExchangeRateWrapper)JSON.deserialize(
            jsonResponse, 
            ExchangeRateWrapper.class
        );
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);

        wrapper.myCurrency = (String) result.get('currency');

        
        return wrapper;
    }

    public static ExchangeRateWrapper parse(String jsonResponse) {
        
        // Use JSON.deserialize to parse the response
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
        ExchangeRateWrapper wrapper = new ExchangeRateWrapper();
        wrapper.result = (String) result.get('result');
        wrapper.documentation = (String) result.get('documentation');
        wrapper.terms_of_use = (String) result.get('terms_of_use');
        wrapper.conversion_rates = (Map<String, Decimal>) result.get('conversion_rates');
        wrapper.myCurrency = (String) result.get('currency');

        return wrapper;
    }



}
# crypto_list

Glade Ng Flutter Assessment Test. 

Note: Ideally we would implement this as a Realtime App. But due to limitations by the Api Provider.
We only allow pull to refresh on the main screen, 
This is so we don't use the API credits given to us by the API provider.

We used the following public APIs
- [Coinmarketcap](https://coinmarketcap.com/api/documentation/v1/#operation/getV2CryptocurrencyQuotesLatest): for the current prices of the cryptocurrencies
- [ApiLayer Currency Data Api](https://apilayer.com/marketplace/currency_data-api?utm_source=apilayermarketplace&utm_medium=featured): for exchange rate between Dollar and Naira

We Used the following packages
- [Riverpod](https://riverpod.dev/) : for state management
- [Dio](https://pub.dev/packages/dio): for network or http calls 
- [Http Mock Adapter](https://pub.dev/packages/http_mock_adapter): To http calls mocking. used for testing
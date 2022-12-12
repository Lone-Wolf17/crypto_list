import 'package:crypto_list/constants/api_endpoints.dart';
import 'package:crypto_list/models/coin_model.dart';
import 'package:crypto_list/repositories/crypto_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late CryptoRepository cryptoRepository;
  final adapterDio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: adapterDio);

  setUp(() {
    cryptoRepository = CryptoRepository(adapterDio);
  });

  test('Retrieved Coins from Coin Marketcap', () async {
    final coinSymbol = ["BTC", "ETH", "LTC", "XRP", "DOGE", "DASH"];

    final url =
        "${ApiEndpoints.coinmarketcapTicker}?symbol=${coinSymbol.join(",")}";

    // Stubbing
    dioAdapter.onGet(
        url,
        (server) => server.reply(200, {
              'status': {'error_code': 0},
              'data': {
                'BTC': [
                  {
                    "name": "Bitcoin",
                    "symbol": "BTC",
                    "quote": {
                      "USD": {"price": 100.0}
                    }
                  }
                ],
                'ETH': [
                  {
                    "name": "Ethereum",
                    "symbol": "ETH",
                    "quote": {
                      "USD": {"price": 100}
                    }
                  }
                ],
                'LTC': [
                  {
                    "name": "Litecoin",
                    "symbol": "LTC",
                    "quote": {
                      "USD": {"price": 100}
                    }
                  }
                ],
                'XRP': [
                  {
                    "name": "Ripple",
                    "symbol": "XRP",
                    "quote": {
                      "USD": {"price": 100}
                    }
                  }
                ],
                'DOGE': [
                  {
                    "name": "DogeCoin",
                    "symbol": "DOGE",
                    "quote": {
                      "USD": {"price": 10}
                    }
                  }
                ],
                'DASH': [
                  {
                    "name": "Dash",
                    "symbol": "DASH",
                    "quote": {
                      "USD": {"price": 10}
                    }
                  }
                ]
              }
            }));

    expect(await cryptoRepository.getCoinPrices(), [
      isA<CoinModel>(),
      isA<CoinModel>(),
      isA<CoinModel>(),
      isA<CoinModel>(),
      isA<CoinModel>(),
      isA<CoinModel>(),
    ]);
  });

  test('Get Dollar rate', () async {
    // Stubbing
    dioAdapter.onGet(
        ApiEndpoints.getDollarConversionRate,
        (server) => server.reply(200, {
              "success": true,
              'result': 750.85,
              "info": {
                "quote": 750.85,
              },
            }));

    expect(await cryptoRepository.getDollarConversionRate(), 750.85);
  });
}

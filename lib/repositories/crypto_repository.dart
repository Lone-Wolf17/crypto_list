import 'dart:developer' as dartDev;

import 'package:crypto_list/config.dart';
import 'package:crypto_list/constants/api_endpoints.dart';
import 'package:crypto_list/models/coin_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRepositoryProvider = Provider((_) => CryptoRepository(Dio()));

class CryptoRepository {
  final Dio dio;

  CryptoRepository(this.dio);

  Future<List<CoinModel>> getCoinPrices() async {
    final headers = {
      'X-CMC_PRO_API_KEY': Config.cmcApikey,
    };

    final coinSymbol = ["BTC", "ETH", "LTC", "XRP", "DOGE", "DASH"];

    final url =
        "${ApiEndpoints.coinmarketcapTicker}?symbol=${coinSymbol.join(",")}";

    final response = await dio.get(url, options: Options(headers: headers));

    final responseJSON = response.data;
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        responseJSON["status"]["error_code"] == 0) {
      return coinSymbol.map((symbol) {
        final res = responseJSON["data"][symbol][0];
        dartDev.log(res.toString());
        return CoinModel.fromJson(res);
      }).toList();
    } else {
      dartDev.log(responseJSON.toString());
      throw Exception("Api Error");
    }
  }

  /// this returns the conversion rate between dollar to naira
  /// for example if the result is 444, hence 1 dollar = 444 naira
  Future<double> getDollarConversionRate() async {
    try {
      final headers = {
        'apikey': Config.currencyConverterApiKey,
      };

      final response = await dio.get(ApiEndpoints.getDollarConversionRate,
          options: Options(headers: headers));

      final responseJSON = response.data;
      if ((response.statusCode == 200 || response.statusCode == 201)) {
        return responseJSON["result"];
      } else {
        dartDev.log(responseJSON.toString());
        throw Exception("Api Error");
      }
    } on DioError catch (e) {
      dartDev.log(e.message);
      rethrow;
    }
  }
}

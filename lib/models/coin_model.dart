class CoinModel {
  final String name;
  final double priceUsd;
  final double? priceNaira;
  final String symbol;

  const CoinModel(this.symbol, this.priceNaira,
      {required this.name, required this.priceUsd});

  CoinModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        symbol = json['symbol'],
        priceUsd = json['quote']['USD']['price'],
        priceNaira =
            json['quote']['NGN'] != null ? json['quote']['NGN']['price'] : 0;

  String get usdPriceStr => "\$${priceUsd.toStringAsFixed(2)}";
}

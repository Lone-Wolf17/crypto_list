class CoinModel {
  final String name;
  final double priceUsd;
  final String symbol;

  const CoinModel(this.symbol, {required this.name, required this.priceUsd});

  CoinModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        symbol = json['symbol'],
        priceUsd =
            num.parse(json['quote']['USD']['price'].toString()).toDouble();

  String get usdPriceStr => "\$${priceUsd.toStringAsFixed(2)}";
}

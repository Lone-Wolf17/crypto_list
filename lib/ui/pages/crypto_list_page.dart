import 'package:crypto_list/models/conversion_screen_arguements.dart';
import 'package:crypto_list/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/coin_model.dart';
import '../../utils/router/navigation_service.dart';
import '../../utils/router/route_names.dart';

final _boldStyle = TextStyle(fontWeight: FontWeight.bold);

/// This is the main page. It fetches and lists the cryptocurrencies.
/// When any of the coins is tapped, we navigate to the Conversion Page
class CryptoListPage extends ConsumerWidget {
  const CryptoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Crypto List'),
        ),
        body: ref.watch(coinListProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, trace) => Center(
                  child: Text(
                'An Error has occurred, Please try again',
                style: _boldStyle,
              )),
              data: (coinList) {
                if (coinList.isEmpty) {
                  return Center(
                      child: Text('No Data returned', style: _boldStyle));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    return await ref.refresh(coinListProvider);
                  },
                  child: ListView.builder(
                      itemCount: coinList.length,
                      itemBuilder: (context, idx) {
                        final Color color =
                            Colors.primaries[idx % Colors.primaries.length];
                        final coin = coinList[idx];
                        return GestureDetector(
                            onTap: () {
                              ref.read(navigationServiceProvider).navigateTo(
                                  RouteNames.conversionPage,
                                  arguments:
                                      ConversionPageArguements(coinList, coin));
                            },
                            child: _CoinListTile(coin: coin, color: color));
                      }),
                );
              },
            ));
  }
}

class _CoinListTile extends StatelessWidget {
  const _CoinListTile({Key? key, required this.coin, required this.color})
      : super(key: key);

  final CoinModel coin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(coin.name[0]),
        ),
        title: Text(coin.name),
        subtitle: Text(
          coin.symbol,
          style: TextStyle(color: Colors.black.withOpacity(0.5)),
        ),
        trailing: Text(
          coin.usdPriceStr,
          style: _boldStyle,
        ),
      ),
    );
  }
}

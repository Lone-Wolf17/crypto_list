import 'package:crypto_list/models/conversion_screen_arguements.dart';
import 'package:crypto_list/ui/pages/convert_to_naira_page.dart';
import 'package:crypto_list/ui/pages/crypto_list_page.dart';
import 'package:crypto_list/utils/router/route_names.dart';
import 'package:flutter/material.dart';

/// Utility Class to declare and manage routes in one place
class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case RouteNames.cryptoListPage:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const CryptoListPage(),
        );
      case RouteNames.conversionPage:
        final args = settings.arguments as ConversionPageArguements;

        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: ConvertToNairaPage(
              coinList: args.coinList, selectedCoin: args.selectedCoin),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static PageRoute _getPageRoute(
      {required String routeName, required Widget viewToShow}) {
    return MaterialPageRoute(
        settings: RouteSettings(
          name: routeName,
        ),
        builder: (_) => viewToShow);
  }
}

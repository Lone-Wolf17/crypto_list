import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationServiceProvider = Provider((_) => NavigationService());

/// Utility class, main goal is to help us navigate without context
/// The advantage of this seen when the app gets large and we begin to separate logic from presentation
class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateWithReplacementTo(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil<T extends dynamic>(
      String newRouteName, bool Function(Route) predicate) {
    return _navigationKey.currentState!
        .pushNamedAndRemoveUntil(newRouteName, predicate);
  }

  void pushNamedIfNotCurrent(String routeName, {Object? arguments}) {
    if (!_isCurrent(routeName)) {
      _navigationKey.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }

  bool _isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }

  void popUntil<T extends dynamic>(bool Function(Route) predicate) {
    return _navigationKey.currentState!.popUntil(predicate);
  }
}

import 'package:flutter/material.dart';

class Navigate {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {dynamic arguments, bool replace = false, bool popPrevious = false}) {
    if (replace)
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);

    if (popPrevious)
      return navigatorKey.currentState!
          .popAndPushNamed(routeName, arguments: arguments);

    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToRemoveUntil(String routeName, String backRouteName,
      {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(backRouteName),
        arguments: arguments);
  }

  void popUntil(String routeName) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  void pop({result}) {
    if (result != null) {
      navigatorKey.currentState!.pop(result);
    } else {
      navigatorKey.currentState!.pop();
    }
  }
}

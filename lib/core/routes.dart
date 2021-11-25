import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/constant/screen_const.dart';
import 'package:restaurant/screen/detail/restaurant_detail_screen.dart';
import 'package:restaurant/screen/favorite/favorite_screen.dart';
import 'package:restaurant/screen/home/restaurant_list_screen.dart';
import 'package:restaurant/screen/search/restaurant_search_screen.dart';
import 'package:restaurant/screen/settings/settings_screen.dart';
import 'package:restaurant/screen/splash_screen.dart';

Route routes(RouteSettings settings) {
  var args = (settings.arguments ?? {}) as Map;
  switch (settings.name) {
    case '/':
      return buildRoute(settings, SplashScreen());
    case ScreenConst.RestaurantList:
      return buildRoute(settings, RestaurantListScreen());
    case ScreenConst.RestaurantDetail:
      return buildRoute(
        settings,
        RestaurantDetailScreen(
          restaurantId: args['restaurantId'],
        ),
      );
    case ScreenConst.RestaurantSearch:
      return buildRoute(settings, RestaurantSearchScreen());
    case ScreenConst.Settings:
      return buildRoute(settings, SettingsScreen());
    case ScreenConst.Favorite:
      return buildRoute(settings, FavoriteScreen());
    default:
      return buildRoute(settings, RestaurantListScreen());
  }
}

MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
  return CustomPageRoute(
    settings: settings,
    builder: (BuildContext context) => builder,
  );
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  final WidgetBuilder builder;
  final RouteSettings settings;

  CustomPageRoute({
    required this.settings,
    required this.builder,
  }) : super(settings: settings, builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: false,
      child: child,
    );
  }
}

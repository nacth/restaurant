import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/common/navigate.dart';
import 'package:restaurant/components/restaurant_card.dart';
import 'package:restaurant/constant/screen_const.dart';
import 'package:restaurant/provider/restaurant_provider.dart';
import 'package:restaurant/utils/notification_helper.dart';

import '../../di.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Restaurant',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    inject<Navigate>().navigateTo(ScreenConst.RestaurantSearch);
                  },
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    inject<Navigate>().navigateTo(ScreenConst.Favorite);
                  },
                  icon: Icon(Icons.favorite),
                ),
                IconButton(
                  onPressed: () {
                    inject<Navigate>().navigateTo(ScreenConst.Settings);
                  },
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Recommendation restaurant for you!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12.0),
            Consumer<RestaurantProvider>(
              builder: (context, provider, _) {
                if (provider.restaurants.isFail) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Oops, Koneksi Bermasalah. Periksa Jaringan Anda',
                          ),
                          IconButton(
                            onPressed: () {
                              provider.getRestaurants();
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (provider.restaurants.isUninitializedOrLoading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => provider.getRestaurants(),
                      child: ListView.separated(
                        itemCount: provider.restaurants.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final restaurant = provider.restaurants.data?[index];
                          return RestaurantCard(restaurant: restaurant);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16.0);
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('restaurant_list_screen : initState');
    _notificationHelper
        .configureSelectNotificationSubject(ScreenConst.RestaurantDetail);
  }

  @override
  void dispose() {
    print('restaurant_list_screen : dispose');
    selectNotificationSubject.close();
    super.dispose();
  }
}

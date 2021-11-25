import 'package:flutter/material.dart';
import 'package:restaurant/common/navigate.dart';
import 'package:restaurant/constant/screen_const.dart';
import 'package:restaurant/core/network/response/restaurant_response.dart';

import '../di.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant? restaurant;
  const RestaurantCard({Key? key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        inject<Navigate>().navigateTo(ScreenConst.RestaurantDetail, arguments: {
          'restaurantId': restaurant?.id,
        });
      },
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 100,
            child: Hero(
              tag: 'image${restaurant?.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/small/${restaurant?.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant?.name ?? 'Restaurant Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 10.0),
                    const SizedBox(width: 4),
                    Text(
                      restaurant?.city ?? 'Restaurant City',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 10),
                    const SizedBox(width: 4),
                    Text(
                      restaurant?.rating.toString() ?? '0.0',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

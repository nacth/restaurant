import 'package:flutter/material.dart';
import 'package:restaurant/core/network/response/restaurant_detail_response.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: restaurant?.menus?.foods?.length ?? 0,
        itemBuilder: (context, index) {
          var food = restaurant?.menus?.foods?[index];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  'https://via.placeholder.com/150x130',
                ),
              ),
              Positioned(
                top: 90,
                left: 10,
                child: Text(
                  food?.name ?? 'Food Name',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                top: 110,
                left: 10,
                child: Text('IDR 15.000'),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8.0);
        },
      ),
    );
  }
}

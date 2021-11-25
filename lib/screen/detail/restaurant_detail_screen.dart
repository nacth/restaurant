import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/core/network/response/restaurant_response.dart';
import 'package:restaurant/provider/database_provider.dart';
import 'package:restaurant/provider/restaurant_provider.dart';

import 'components/add_review.dart';
import 'components/drink_item.dart';
import 'components/food_item.dart';
import 'components/review_item.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;
  const RestaurantDetailScreen({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context
          .read<RestaurantProvider>()
          .getRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, provider, _) {
            if (provider.restaurantDetail.isFail) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oops, Koneksi Bermasalah. Periksa Jaringan Anda',
                    ),
                    IconButton(
                      onPressed: () {
                        provider.getRestaurantDetail(widget.restaurantId);
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            } else if (provider.restaurantDetail.isUninitializedOrLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final restaurant = provider.restaurantDetail.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: 'image${restaurant?.id}',
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/small/${restaurant?.pictureId}',
                            ),
                          ),
                        ),
                        Consumer<DatabaseProvider>(
                          builder: (context, provider, _) {
                            return FutureBuilder<bool>(
                              future:
                                  provider.isFavorited(restaurant?.id ?? ''),
                              builder: (context, snapshot) {
                                var isFavorited = snapshot.data ?? false;
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        isFavorited
                                            ? provider.removeFavorite(
                                                restaurant?.id ?? '')
                                            : provider.addFavorite(
                                                Restaurant(
                                                  id: restaurant?.id,
                                                  name: restaurant?.name,
                                                  description:
                                                      restaurant?.description,
                                                  pictureId:
                                                      restaurant?.pictureId,
                                                  city: restaurant?.city,
                                                  rating: restaurant?.rating,
                                                ),
                                              );
                                      },
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        isFavorited
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant?.name ?? 'Restaurant Name',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                restaurant?.city ?? 'Restaurant City',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            restaurant?.description ?? 'Restaurant Description',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Foods',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FoodItem(restaurant: restaurant),
                          const SizedBox(height: 20),
                          const Text(
                            'Drinks',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DrinkItem(restaurant: restaurant),
                          const SizedBox(height: 20),
                          const Text(
                            'Review',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          ReviewItem(restaurant: restaurant),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12.0),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return AddReview(
                                      provider: provider,
                                    );
                                  },
                                );
                              },
                              child: Text('Tambahkan Review'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

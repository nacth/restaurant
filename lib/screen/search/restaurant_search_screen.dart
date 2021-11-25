import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/components/restaurant_card.dart';
import 'package:restaurant/provider/restaurant_provider.dart';

class RestaurantSearchScreen extends StatefulWidget {
  @override
  State<RestaurantSearchScreen> createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  @override
  void initState() {
    context.read<RestaurantProvider>().restaurantSearch.data = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 12.0),
                Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  hintText: 'Restaurant Name',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (value != '') {
                    context
                        .read<RestaurantProvider>()
                        .getRestaurantSearch(value);
                  }
                },
              ),
            ),
            Consumer<RestaurantProvider>(
              builder: (context, provider, _) {
                if (provider.restaurantSearch.isFail) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Oops, Koneksi Bermasalah. Periksa Jaringan Anda',
                      ),
                    ),
                  );
                } else if (provider.restaurantSearch.isUninitialized) {
                  return Expanded(
                    child: Center(
                      child: Text('Restaurant Tidak Ditemukan!'),
                    ),
                  );
                } else if (provider.restaurantSearch.isLoading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return (provider.restaurantSearch.data?.length == 0)
                      ? Expanded(
                          child: Center(
                            child: Text('Restaurant Tidak Ditemukan!'),
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemCount:
                                provider.restaurantSearch.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final restaurant =
                                  provider.restaurantSearch.data?[index];
                              return RestaurantCard(restaurant: restaurant);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16.0);
                            },
                          ),
                        );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

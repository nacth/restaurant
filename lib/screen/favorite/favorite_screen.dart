import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/components/restaurant_card.dart';
import 'package:restaurant/provider/database_provider.dart';
import 'package:restaurant/utils/result_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 12.0),
                Text(
                  'Favorite Restaurant',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Consumer<DatabaseProvider>(
              builder: (context, provider, _) {
                if (provider.state == ResultState.Loading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (provider.state == ResultState.HasData) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => provider.favorites,
                      child: ListView.separated(
                        itemCount: provider.favorites.length,
                        itemBuilder: (context, index) {
                          final restaurant = provider.favorites[index];
                          return RestaurantCard(restaurant: restaurant);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16.0);
                        },
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text(provider.message),
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
}

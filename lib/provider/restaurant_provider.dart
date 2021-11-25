import 'package:flutter/cupertino.dart';
import 'package:restaurant/common/async.dart';
import 'package:restaurant/core/custom_change_notifier.dart';
import 'package:restaurant/core/network/request/add_review_request.dart';
import 'package:restaurant/core/network/response/restaurant_add_review_response.dart';
import 'package:restaurant/core/network/response/restaurant_detail_response.dart'
    as RestaurantDetail;
import 'package:restaurant/core/network/response/restaurant_response.dart'
    as Restaurant;
import 'package:restaurant/core/network/response/restaurant_search_response.dart';
import 'package:restaurant/core/network/service/restaurant_service.dart';

import '../di.dart';

class RestaurantProvider extends CustomChangeNotifier {
  RestaurantProvider() {
    getRestaurants();
  }

  final _restaurantService = inject.get<RestaurantService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  Async<List<Restaurant.Restaurant>> restaurants =
      uninitialized<List<Restaurant.Restaurant>>();
  Async<RestaurantDetail.Restaurant> restaurantDetail =
      uninitialized<RestaurantDetail.Restaurant>();
  Async<List<Restaurant.Restaurant>> restaurantSearch =
      uninitialized<List<Restaurant.Restaurant>>();
  Async<List<RestaurantDetail.CustomerReview>> restaurantReview =
      uninitialized<List<RestaurantDetail.CustomerReview>>();

  void getRestaurants() async {
    customApi(
      service: _restaurantService.getRestaurants(),
      object: restaurants,
      execute: (Restaurant.RestaurantResponse response) {
        restaurants.success(
          response.restaurants ?? [],
        );
      },
    );
  }

  void getRestaurantDetail(String restaurantId) async {
    customApi(
      service: _restaurantService.getRestaurantDetail(restaurantId),
      object: restaurantDetail,
      execute: (RestaurantDetail.RestaurantDetailResponse response) {
        restaurantDetail.success(
          response.restaurant ?? RestaurantDetail.Restaurant(),
        );
      },
    );
  }

  void getRestaurantSearch(String query) async {
    customApi(
      service: _restaurantService.getRestaurantSearch(query),
      object: restaurantSearch,
      execute: (RestaurantSearchResponse response) {
        restaurantSearch.success(
          response.restaurants ?? [],
        );
      },
    );
  }

  void postRestaurantReview() async {
    final request = AddReview(
      id: restaurantDetail.data?.id,
      name: nameController.text,
      review: reviewController.text,
    );
    await customApi(
      service: _restaurantService.postRestaurantReview(request),
      object: restaurantReview,
      execute: (RestaurantAddReviewResponse response) {
        restaurantReview.success(response.customerReviews ?? []);
      },
    );
    restaurantDetail.data?.customerReviews
        ?.add(restaurantReview.data?.last ?? RestaurantDetail.CustomerReview());
    notifyListeners();
    nameController.text = '';
    reviewController.text = '';
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }
}

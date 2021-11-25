import 'package:dio/dio.dart';
import 'package:restaurant/core/network/request/add_review_request.dart';
import 'package:restaurant/core/network/response/restaurant_add_review_response.dart';
import 'package:restaurant/core/network/response/restaurant_detail_response.dart';
import 'package:restaurant/core/network/response/restaurant_response.dart';
import 'package:restaurant/core/network/response/restaurant_search_response.dart';

import '../client.dart';

class RestaurantService {
  final Dio _client;

  RestaurantService(this._client);

  Future<RestaurantResponse> getRestaurants() async {
    return await clientExecutor<RestaurantResponse>(execute: () async {
      var response = await _client.get('/list');
      return RestaurantResponse.fromJson(
        response.data,
      );
    });
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(
    String restaurantId,
  ) async {
    return await clientExecutor<RestaurantDetailResponse>(execute: () async {
      var response = await _client.get('/detail/$restaurantId');
      return RestaurantDetailResponse.fromJson(response.data);
    });
  }

  Future<RestaurantSearchResponse> getRestaurantSearch(
    String query,
  ) async {
    return await clientExecutor<RestaurantSearchResponse>(execute: () async {
      var response =
          await _client.get('/search', queryParameters: {'q': query});
      return RestaurantSearchResponse.fromJson(response.data);
    });
  }

  Future<RestaurantAddReviewResponse> postRestaurantReview(
    AddReview request,
  ) async {
    return await clientExecutor<RestaurantAddReviewResponse>(execute: () async {
      var response = await _client.post('/review', data: {
        'id': request.id,
        'name': request.name,
        'review': request.review,
      });
      return RestaurantAddReviewResponse.fromJson(response.data);
    });
  }
}

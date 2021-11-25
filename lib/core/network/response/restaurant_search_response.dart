import 'dart:convert';

import 'restaurant_response.dart';

RestaurantSearchResponse restaurantSearchResponseFromJson(String str) =>
    RestaurantSearchResponse.fromJson(json.decode(str));

String restaurantSearchResponseToJson(RestaurantSearchResponse data) =>
    json.encode(data.toJson());

class RestaurantSearchResponse {
  RestaurantSearchResponse({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool? error;
  int? founded;
  List<Restaurant>? restaurants;

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

import 'dart:convert';

import 'restaurant_detail_response.dart';

RestaurantAddReviewResponse restaurantAddReviewResponseFromJson(String str) =>
    RestaurantAddReviewResponse.fromJson(json.decode(str));

String restaurantAddReviewResponseToJson(RestaurantAddReviewResponse data) =>
    json.encode(data.toJson());

class RestaurantAddReviewResponse {
  RestaurantAddReviewResponse({
    this.error,
    this.message,
    this.customerReviews,
  });

  bool? error;
  String? message;
  List<CustomerReview>? customerReviews;

  factory RestaurantAddReviewResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantAddReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}

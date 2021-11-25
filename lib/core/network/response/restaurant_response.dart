import 'dart:convert';

RestaurantResponse restaurantResponseFromJson(String str) =>
    RestaurantResponse.fromJson(json.decode(str));

String restaurantResponseToJson(RestaurantResponse data) =>
    json.encode(data.toJson());

class RestaurantResponse {
  RestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool? error;
  String? message;
  int? count;
  List<Restaurant>? restaurants;

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: (json["rating"].runtimeType == String)
            ? double.parse(json["rating"])
            : json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

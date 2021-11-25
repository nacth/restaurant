import 'package:flutter/material.dart';
import 'package:restaurant/core/network/response/restaurant_detail_response.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.separated(
        itemCount: restaurant?.customerReviews?.length ?? 0,
        itemBuilder: (context, index) {
          final review = restaurant?.customerReviews?[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    review?.name ?? 'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    review?.date ?? 'Date',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              subtitle: Text(review?.review ?? 'Review'),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8.0);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant/provider/restaurant_provider.dart';

class AddReview extends StatelessWidget {
  final RestaurantProvider provider;
  const AddReview({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 20.0,
      ),
      child: Wrap(
        children: [
          Container(
            width: double.infinity,
            child: Icon(Icons.arrow_drop_down),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey),
            ),
            child: TextField(
              controller: provider.nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12.0),
                border: InputBorder.none,
                hintText: 'Nama',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey),
            ),
            child: TextField(
              controller: provider.reviewController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12.0),
                border: InputBorder.none,
                hintText: 'Review',
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                if (provider.nameController.text != '' &&
                    provider.reviewController.text != '') {
                  provider.postRestaurantReview();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Isi kolom Nama dan Review terlebih dahulu',
                      ),
                    ),
                  );
                }
              },
              child: Text('Tambah'),
            ),
          ),
        ],
      ),
    );
  }
}

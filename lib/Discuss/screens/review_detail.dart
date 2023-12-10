import 'package:litera_land_mobile/Discuss/models/review_data.dart';
import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final ReviewBook item;

  const ReviewDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.fields.reviewerName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Jika ada gambar item, tambahkan di sini
                    Text("name: ${item.fields.reviewerName}",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text("Rating: ${item.fields.starRating}"),
                    const SizedBox(height: 8),
                    Text("Review: ${item.fields.review}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

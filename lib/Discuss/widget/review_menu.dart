// ignore: file_names
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Discuss/models/review_data.dart'; // Update with correct path

class ReviewListTile extends StatelessWidget {
  final ReviewBook reviewBook;

  const ReviewListTile({super.key, required this.reviewBook});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        reviewBook.fields.reviewerName, // Displaying the reviewer's name
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: ${reviewBook.fields.date.toString()}', // Displaying the review date
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Text(
            'Rating: ${reviewBook.fields.starRating} stars', // Displaying the star rating
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Text(
            'Review: ${reviewBook.fields.review}', // Displaying the review text
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      onTap: () {
        // Implement the onTap action here, if needed
        // Example: Navigate to a detailed review page
      },
      // Other styling and behavior
    );
  }
}

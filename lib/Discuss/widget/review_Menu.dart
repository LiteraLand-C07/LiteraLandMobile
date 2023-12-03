import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Discuss/models/review_data.dart'; // Update with correct path

class ReviewBookWidget extends StatelessWidget {
  final ReviewBook reviewBook;

  const ReviewBookWidget({super.key, required this.reviewBook});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reviewBook.greeting,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 10),
        ...reviewBook.instructions
            .map((instruction) => Text(
                  instruction,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ))
            .toList(),
      ],
    );
  }
}

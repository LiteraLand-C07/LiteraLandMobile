import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litera_land_mobile/Discuss/models/review_data.dart';
import 'package:litera_land_mobile/Discuss/screens/review_list.dart';

class ReviewDetailPage extends StatelessWidget {
  final ReviewBook item;
  final int bookId;

  const ReviewDetailPage({Key? key, required this.item, required this.bookId})
      : super(key: key);

  Future<void> deleteReview(int reviewId) async {
    var url = Uri.parse(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/forumDiskusi/delete_flutter/$reviewId/');
    var response =
        await http.post(url, body: {'review_id': reviewId.toString()});

    if (response.statusCode == 200) {
      // Handle successful delete
    } else {
      // Handle failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: Text(item.fields.reviewerName),
        backgroundColor:
            const Color.fromARGB(255, 15, 15, 15),
            foregroundColor: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDeleteConfirmationDialog(context),
        tooltip: 'Delete Review',
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to delete this review?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text("Delete"),
                onPressed: () async {
                  await deleteReview(item.pk); // Delete the review
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewsPage(
                              bookId: bookId,
                            )),
                  );
                }),
          ],
        );
      },
    );
  }
}

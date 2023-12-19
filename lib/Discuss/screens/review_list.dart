import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litera_land_mobile/Discuss/models/review_data.dart';
import 'package:litera_land_mobile/Discuss/screens/review_detail.dart';
import 'package:litera_land_mobile/Discuss/screens/review_form.dart';
import 'package:litera_land_mobile/Discuss/widget/left_drawer.dart';

class ReviewsPage extends StatefulWidget {
  final int bookId;
  const ReviewsPage({Key? key, required this.bookId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  Future<List<ReviewBook>> fetchProduct() async {
    var url = Uri.parse(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/forumDiskusi/json_id/${widget.bookId}/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<ReviewBook> listProduct = [];
      for (var d in data) {
        if (d != null) {
          listProduct.add(ReviewBook.fromJson(d));
        }
      }
      return listProduct;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 66, 66),
      appBar: AppBar(
        title: const Text('Reviews'),
        backgroundColor:
            const Color.fromARGB(255, 15, 15, 15),
            foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(
        bookId: widget.bookId,
      ),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching reviews'));
          } else if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewDetailPage(
                          item: product,
                          bookId: widget.bookId,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.fields.reviewerName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text("Rating: ${product.fields.starRating}"),
                          const SizedBox(height: 8),
                          Text("Review: ${product.fields.review}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No reviews found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Replace with the actual navigation to your ItemFormPage
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemFormPage(
                      bookId: widget.bookId,
                    )),
          );
        },
        tooltip: 'Add Review',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:convert';
// import 'package:crimson_chest_mobile/screens/ItemDetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:litera_land_mobile/Discuss/screens/review_detail.dart';
// import 'package:crimson_chest_mobile/models/product.dart';
import 'package:litera_land_mobile/Discuss/widget/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Discuss/models/review_data.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ReviewsPage> {
  Future<List<ReviewBook>> fetchProduct() async {
    var url = Uri.parse(
        'https://literaland-c07-tk.pbp.cs.ui.ac.id/forumDiskusi/show_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<ReviewBook> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ReviewBook.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching products'));
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
                        builder: (context) => ReviewDetailPage(item: product),
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
                          Text("Price: \$${product.fields.starRating}"),
                          const SizedBox(height: 8),
                          Text("Description: ${product.fields.review}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, sized_box_for_whitespace, must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:litera_land_mobile/collections/screens/detail_book.dart';
import 'package:litera_land_mobile/collections/screens/mycollection.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CollectionFormModal extends StatefulWidget {
  int rating;
  int page;
  String status_baca;
  final bool is_edit;
  final int max_page;
  final int bookId;
  int collectionId;
  bool isInCollection;
  bool isFromCollection;

  CollectionFormModal({
    Key? key,
    this.rating = 1,
    this.page = 1,
    this.status_baca = 'PR',
    required this.max_page,
    required this.is_edit,
    required this.bookId,
    this.collectionId = -1,
    this.isInCollection = false,
    this.isFromCollection = false,
  }) : super(key: key);

  @override
  _CollectionFormModalState createState() => _CollectionFormModalState();
}

class _CollectionFormModalState extends State<CollectionFormModal> {
  final _formKey = GlobalKey<FormState>();

  String _getStatusText(String status) {
    if (status == "Completed") {
      return "C";
    } else if (status == "Plan to Read") {
      return "PR";
    } else if (status == "Dropped") {
      return "D";
    } else if (status == 'Reading') {
      return "R";
    }
    return '';
  }

  late int _rating = widget.rating;
  late int _page = widget.page;
  late String _status = widget.status_baca;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Container(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Rating: $_rating',
                style: const TextStyle(fontSize: 16),
              ),
              Slider(
                value: _rating.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: (double value) {
                  setState(() {
                    // Update the widget property directly
                    _rating = value.toInt(); // Update the local variable
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _page.toString(),
                decoration: const InputDecoration(labelText: 'Page'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _page = int.tryParse(value) ?? 1;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Jumlah halaman tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Jumlah harus berupa angka!";
                  }
                  if (int.tryParse(value)! > widget.max_page) {
                    return "Jumlah Halaman maximal sebanyak ${widget.max_page}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Status:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: _status,
                onChanged: (String? value) {
                  setState(() {
                    _status = value!;
                  });
                },
                items: <String>[
                  'Plan to Read',
                  'Reading',
                  'Completed',
                  'Dropped',
                ].map<DropdownMenuItem<String>>((String status) {
                  return DropdownMenuItem<String>(
                    value: _getStatusText(status),
                    child: Text(status),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.is_edit) {
                      String url =
                          "https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/edit_flutter/${widget.collectionId}/";
                      var data = jsonEncode(<String, String>{
                        'rating': _rating.toString(),
                        'current_page': _page.toString(),
                        'status_baca': _status.toString(),
                      });
                      final response = await request.postJson(url, data);
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Progress baru berhasil disimpan!"),
                        ));
                        Navigator.of(context).pop();
                        if (widget.isInCollection) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const CollectionPage(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => BookDetailPage(
                                bookId: widget.bookId,
                                isFromCollection: widget.isFromCollection,
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                        ));
                      }
                    } else {
                      String url =
                          "https://literaland-c07-tk.pbp.cs.ui.ac.id/collections/create_flutter/${widget.bookId}/";
                      var data = jsonEncode(<String, String>{
                        'rating': _rating.toString(),
                        'current_page': _page.toString(),
                        'status_baca': _status.toString(),
                      });
                      final response = await request.postJson(url, data);
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Buku berhasil disimpan di daftar koleksi!"),
                        ));
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              bookId: widget.bookId,
                              isFromCollection: widget.isFromCollection,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                        ));
                      }
                    }
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ));
  }
}

// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';

class CollectionFormModal extends StatefulWidget {
  int rating;
  int page;
  String status_baca;
  final int max_page;

  CollectionFormModal({
    Key? key,
    this.rating = 1,
    this.page = 1,
    this.status_baca = 'PR',
    required this.max_page,
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
                divisions: 9,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lakukan sesuatu dengan data yang telah diisi
                    Navigator.of(context).pop();
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ));
  }
}

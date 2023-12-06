// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:litera_land_mobile/Admin/widgets/inbox.dart';
import 'package:litera_land_mobile/Admin/widgets/form.dart';


class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Books'),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15), // Dark themed AppBar color
        foregroundColor: Colors.white, // Text color for AppBar
      ),
      // drawer: ,

      body: Flex (
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          const Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: QueueForm(),
            )
          )
        ]
      )
    );
  }
}
// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/widgets/form.dart';
import 'package:litera_land_mobile/Main/widgets/left_drawer.dart';
import 'package:litera_land_mobile/Main/widgets/bottom_navbar.dart';

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
      drawer: const LeftDrawer(),
      bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 3,
      ),

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
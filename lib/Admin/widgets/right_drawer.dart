// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:litera_land_mobile/Admin/widgets/queue_list.dart';
import 'package:litera_land_mobile/Admin/widgets/inbox.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:litera_land_mobile/Admin/screens/admin.dart';

class RightDrawer extends StatefulWidget{
  const RightDrawer({Key? key}) : super(key: key);

  @override
  State<RightDrawer> createState() => _RightDrawer();
}

class _RightDrawer extends State<RightDrawer> {
  bool isInbox = true;
  @override
  Widget build(BuildContext context){
  final request = context.watch<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Column(
                children: [
                  Text(
                    isInbox? 'Book Requests' : 'Book Queues',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: !isInbox
                            ? () {
                                setState(() {
                                  isInbox = true;
                                });
                              }
                            : null,
                        child: const Text('Inbox'),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: isInbox
                            ? () {
                                setState(() {
                                  isInbox = false;
                                });
                              }
                            : null,
                        child: const Text('Queues'),
                      ),
                    ],
                  ),
                ],
              ) 
            ),
          ),
          Expanded(
            child: isInbox? const Inbox() : const QueueList(),
          ),
          if (!isInbox)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                onPressed: () async {
                  await request.post(
                    'https://literaland-c07-tk.pbp.cs.ui.ac.id/administrator/confirm-queue',
                    jsonEncode(<String, String>{
                            'something': 'something',
                          } 
                  ));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPage()));
                }, 
                child: const Text("Confirm Queue")
              ),
            )
        ],
      ),
    );
  }
}
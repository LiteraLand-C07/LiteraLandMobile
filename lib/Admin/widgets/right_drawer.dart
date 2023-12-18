// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

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
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 30, 29, 29),
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
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: isInbox? MaterialStateProperty.all(const Color.fromARGB(255, 67, 67, 67)) : MaterialStateProperty.all(const Color.fromARGB(255, 152, 148, 148)),
                        ),
                        onPressed: !isInbox? () {
                                setState(() {
                                  isInbox = true;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: !isInbox? MaterialStateProperty.all(const Color.fromARGB(255, 67, 67, 67)) : MaterialStateProperty.all(const Color.fromARGB(255, 152, 148, 148)),
                        ),
                        onPressed: isInbox? () {
                                setState(() {
                                  isInbox = false;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.queue,
                          color: Colors.black,
                          size: 20,
                        ),
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton.icon(
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
                icon: const Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 20,
                ),
                label: const Text("Confirm")
              ),
            )
        ],
      ),
    );
  }
}
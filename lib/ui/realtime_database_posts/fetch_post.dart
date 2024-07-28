import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/utilies/utils.dart';
import 'package:flutter/material.dart';

class FetchPostScreen extends StatefulWidget {
  const FetchPostScreen({super.key});

  @override
  State<FetchPostScreen> createState() => _FetchPostScreenState();
}

class _FetchPostScreenState extends State<FetchPostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Fetch Post'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.snapshot.value == null) {
                return const Center(
                  child: Text('Nothing to show'),
                );
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();

                // Filter the list based on the search input
                List<dynamic> filteredlist = list.where((post) {
                  String title = post['title'].toString().toLowerCase();
                  String searchQuery =
                      searchController.text.toString().toLowerCase();
                  return title.contains(searchQuery);
                }).toList();

                if (filteredlist.isEmpty) {
                  return const Center(
                    child: Text('No Result Found'),
                  );
                }

                return ListView.builder(
                    itemCount: filteredlist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredlist[index]['title']),
                        subtitle: Text(filteredlist[index]['id']),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text('Edit'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialog(filteredlist[index]['title'],
                                        filteredlist[index]['id']);
                                  },
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text('Delete'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(filteredlist[index]['id'])
                                        .remove()
                                        .then((_) {
                                      Utils().toastMessage('Post Deleted');
                                    }).catchError((error) {
                                      Utils().toastMessage(error.toString());
                                    });
                                  },
                                )),
                          ],
                        ),
                      );
                    });
              }
            },
          )),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ref.child(id).update({
                      'title': editController.text.toLowerCase()
                    }).then((value) {
                      Utils().toastMessage('Post Updated');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
            ],
          );
        });
  }
}

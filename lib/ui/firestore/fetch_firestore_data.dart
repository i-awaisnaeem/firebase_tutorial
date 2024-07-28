import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utilies/utils.dart';

class FetchFirestoreDataScreen extends StatefulWidget {
  const FetchFirestoreDataScreen({super.key});

  @override
  State<FetchFirestoreDataScreen> createState() => _FetchFirestoreDataScreenState();
}

class _FetchFirestoreDataScreenState extends State<FetchFirestoreDataScreen> {

  final editController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Fetch Firestore Data'),
      ),
      body: Column(
        children: [
              const SizedBox(height: 10,),
           StreamBuilder<QuerySnapshot>(
               stream: fireStore, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                 if (snapshot.connectionState == ConnectionState.waiting){
                   return const Center(child: CircularProgressIndicator(),);
                 }
                 if (snapshot.hasError){
                   return const Text('There is an error');
                 }
                 else{
                 return Expanded(child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context,index){
                    return ListTile(
                      title: Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
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
                                  showMyDialog(
                                    snapshot.data!.docs[index]['title'].toString(),
                                    snapshot.data!.docs[index]['id'].toString(),
                                  );
                                },
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text('Delete'),
                                onTap: () {
                                  Navigator.pop(context);
                                 ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                },
                              )),
                        ],
                      ),
                    );
                   }
                 )
                 );
                 }
           }),
        ],
      )
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
                  ref.doc(id).update({
                    'title': editController.text.toLowerCase()
                  });
                  Navigator.pop(context);
                },
                child: const Text('Update')),
          ],
        );
      });
}
}
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/utilies/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  bool loading = false;
  final postController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder()
              ),
              controller: postController,
            ),
            const SizedBox(height: 30,),
            RoundButton(
                tilte: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true; });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  databaseRef.child(id).set({
                    'id' : id,
                    'title' : postController.text.toString()
                  }).then((value){
                    Utils().toastMessage('Post added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error , stackTrace){
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
}

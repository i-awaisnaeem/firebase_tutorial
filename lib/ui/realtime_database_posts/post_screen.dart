import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/utilies/routes_name.dart';
import 'package:firebase_project/utilies/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';


class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text ('Post'),
        actions: [
          IconButton(onPressed: (){
              auth.signOut().then((value) {
                Navigator.pushNamed(context, RouteName.LoginScreen);
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
              });
          }, icon: const Icon(Icons.logout),),
          const SizedBox(width: 30,),


        ],
      ),
     // floatingActionButton: FloatingActionButton(
     //     onPressed: (){
      //      Navigator.pushNamed(context, RouteName.AddPostScreen);
      //    },
  //    child: Icon(Icons.add),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            RoundButton(
                tilte: 'Add Data to Realtime Database',
                onTap: (){
                  Navigator.pushNamed(context, RouteName.AddPostScreen);
                }),
            const SizedBox(height: 40,),
            RoundButton(
                tilte: 'Fetch Update Delete Data from Realtime Database',
                onTap: (){
                  Navigator.pushNamed(context, RouteName.FetchPostScreen);
                }),
            const SizedBox(height: 40,),
            RoundButton(
                tilte: 'Add Data to Firestore Database',
                onTap: (){
                  Navigator.pushNamed(context, RouteName.AddFirestorDataScreen);
                }),
            const SizedBox(height: 40,),
            RoundButton(
                tilte: 'Fetch Update Delete data from firestore',
                onTap: (){
                  Navigator.pushNamed(context, RouteName.FetchFirestoreDataScreen);
                } ),
            const SizedBox(height: 40,),
            RoundButton(
                tilte: 'Upload Image to firestore',
                onTap: (){
                  Navigator.pushNamed(context, RouteName.UploadImageScreen);
                } )
          ],
        ),
      ),
    );
  }
}

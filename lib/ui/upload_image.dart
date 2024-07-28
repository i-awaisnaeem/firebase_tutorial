import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/utilies/utils.dart';
import  'package:image_picker/image_picker.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null){
        _image = File(pickedFile.path);
      }
      else{
        const Text('No image');
      }
    });
  }

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImageGallery();
                },
                child: Container(
                  height: 300, width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: _image != null ? Image.file(_image!.absolute) :
                  const Center(child: Icon(Icons.image),) ,
                ),
              ),
            ),
            const SizedBox(height: 40,),
            RoundButton(tilte: 'Upload Image',loading: loading, onTap: () async {
              setState(() {
                loading = true;
              });
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage
                  .instance.ref('/foldername' + '' +DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask = ref.putFile(
                  _image!.absolute);

               Future.value(uploadTask);
              var newUrl = await ref.getDownloadURL();

              databaseRef.child('1').set({
                'id' : '1234',
                'title' : newUrl.toString()
              }).then((value){
                Utils().toastMessage('Uploaded');
                setState(() {
                  loading = false;
                });

              }).onError((error, stackTrace){
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

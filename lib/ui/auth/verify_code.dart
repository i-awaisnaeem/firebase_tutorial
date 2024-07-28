import 'package:firebase_project/utilies/routes_name.dart';
import 'package:firebase_project/utilies/utils.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {

  final verificationId;
  VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final auth = FirebaseAuth.instance;

  bool loading = false;
  final verificationCoderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Verify'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: verificationCoderController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_outlined),
                  hintText: '6 Digits Code'
              ),
            ),
          ),
          const SizedBox(height: 80,),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(tilte: 'Verify',
                  loading: loading,
                  onTap: () async {
                setState(() {
                  loading = true;
                });
                final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationCoderController.text.toString());
              try{
                await auth.signInWithCredential(credentials);
                Navigator.pushNamed(context, RouteName.PostScreen);
              }
              catch(e){
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(e.toString());
              }
              })
          )],
      ),);
  }
}

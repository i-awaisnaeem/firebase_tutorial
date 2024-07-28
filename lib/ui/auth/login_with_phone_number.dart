import "package:firebase_project/utilies/routes_name.dart";
import "package:firebase_project/utilies/utils.dart";
import "package:firebase_project/widgets/round_button.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  final auth = FirebaseAuth.instance;

  bool loading = false;
 final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Login'),
      ),
    body: Column(
      children: [
          const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: phoneNumberController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone_outlined),
              hintText: '+1 234 5678 923'
            ),
          ),
        ),
        const SizedBox(height: 80,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RoundButton(tilte: 'Login',
              loading: loading,
              onTap: () {
            setState(() {
              loading = true;
            });
            auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                verificationCompleted: (PhoneAuthCredential credential ) {
                  setState(() {
                    loading = false;
                  });
                },
                verificationFailed: (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                },
                codeSent: (String verificationId , int? token){
                  Navigator.pushNamed(context, RouteName.VerifyCodeScreen,
                  arguments: {
                     'verificationId': verificationId
                  });
                  setState(() {
                    loading = false;
                  });
                },
                codeAutoRetrievalTimeout: (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                });
          })
        )],
    ),);
  }
}

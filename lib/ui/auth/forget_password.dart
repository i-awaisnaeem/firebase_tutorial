import 'package:firebase_project/utilies/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
              loading: loading,
                tilte: 'Forget',
                onTap: () {
                setState(() {
                  loading = true;
                });
                  auth
                      .sendPasswordResetEmail(email: emailController.text.toString())
                      .then((value) {
                        loading=false;
                        Utils().toastMessage('Recovery Email Sent!');
                  })
                      .onError((error, stackTrace) {
                        loading = false;
                        Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_project/utilies/routes_name.dart';
import 'package:firebase_project/utilies/utils.dart';
import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _auth  = FirebaseAuth.instance;

  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void signup(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString() ,
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace ){
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Sign up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                        controller: emailController ,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email)
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Enter Email';
                          }
                          return null;}
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController ,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline)
                      ),
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundButton(tilte: 'Sign up',
                loading: loading,
                onTap: () {
              if (_formkey.currentState!.validate())  {
                signup();
              }
            })),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.LoginScreen);
              },
                  child: const Text('Login',
                    style: TextStyle(
                        color: Colors.blueAccent
                    ),))
            ],
          )
        ],
      ),
    );
  }
}


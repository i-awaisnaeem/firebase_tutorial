import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/utilies/routes_name.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_project/utilies/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;

  bool loading = false;
final _formkey = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();

@override
void dispose() {
  // TODO: implement dispose
  super.dispose();
  emailController.dispose();
  passwordController.dispose();
}

void login(){
  setState(() {
    loading = true;
  });
  _auth.signInWithEmailAndPassword(email: emailController.text.toString(),
      password: passwordController.text.toString()).then((value){
        Utils().toastMessage(value.user!.email.toString());
        Navigator.pushNamed(context, RouteName.PostScreen);
    setState(() {
    loading = false;
    });
  }).onError((error , stackTrace){
    debugPrint(error.toString());
    Utils().toastMessage(error.toString());
    setState(() {
    loading = false;
    });
  });

}

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: true ,
    onPopInvoked: (bool){
      SystemNavigator.pop();
    },
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: emailController ,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              // helperText: 'Entre Email e.g abc@gmail.com',
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
                      padding: const EdgeInsets.all(10.0),
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
              child: RoundButton(
                  tilte: 'Login',
                  loading: loading,
                  onTap: (){
                if (_formkey.currentState!.validate()){
                  login();
                }
              }),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: (){
                Navigator.pushNamed(context, RouteName.ForgetPasswordScreen);
              },
                  child: const Text('Forget Password',
                    style: TextStyle(
                        color: Colors.blueAccent
                    ),)),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteName.SignupScreen);
                },
                    child: const Text('Sign up',
                      style: TextStyle(
                          color: Colors.blueAccent
                      ),))
              ],
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RouteName.LoginWithPhoneNumber);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Colors.black
                      )
                  ),
                  child: const Center(
                    child: Text('Login with phone'),
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    ),
  );
}
}

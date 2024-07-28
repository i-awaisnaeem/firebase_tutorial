import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/utilies/routes_name.dart';
import 'package:flutter/cupertino.dart';

class SplashServices{

  void isLogin(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null){
      Timer(const Duration(seconds: 3), (){
        Navigator.pushNamed(context, RouteName.PostScreen);
      });
    }
    else{
      Timer(const Duration(seconds: 3), (){
        Navigator.pushNamed(context, RouteName.LoginScreen);
      });
    }
  }

}
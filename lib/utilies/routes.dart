import 'package:firebase_project/ui/auth/forget_password.dart';
import 'package:firebase_project/ui/auth/login_screen.dart';
import 'package:firebase_project/ui/auth/signup_screen.dart';
import 'package:firebase_project/ui/auth/verify_code.dart';
import 'package:firebase_project/ui/firestore/add_firestore_data.dart';
import 'package:firebase_project/ui/firestore/fetch_firestore_data.dart';
import 'package:firebase_project/ui/realtime_database_posts/add_post.dart';
import 'package:firebase_project/ui/splash_screen.dart';
import 'package:firebase_project/ui/upload_image.dart';
import 'package:firebase_project/utilies/routes_name.dart';
import 'package:flutter/material.dart';
import '../ui/auth/login_with_phone_number.dart';
import '../ui/realtime_database_posts/fetch_post.dart';
import '../ui/realtime_database_posts/post_screen.dart';

class Routes{

    static Route<dynamic> generateRoute (RouteSettings settings){

    switch(settings.name){

      case RouteName.SplashScreen:
        return MaterialPageRoute(builder: (context)=> const SplashScreen());

      case RouteName.LoginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RouteName.SignupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());

      case RouteName.PostScreen:
        return MaterialPageRoute(builder: (context) => const PostScreen());

      case RouteName.LoginWithPhoneNumber:
        return MaterialPageRoute(builder: (context) => const LoginWithPhoneNumber());

      case RouteName.VerifyCodeScreen:
        return MaterialPageRoute(builder: (context) =>  VerifyCodeScreen(
          verificationId: settings.arguments as String,
        ));

      case RouteName.AddPostScreen:
        return MaterialPageRoute(builder: (context) => const AddPostScreen());

      case RouteName.FetchPostScreen:
        return MaterialPageRoute(builder: (context) => const FetchPostScreen());

      case RouteName.AddFirestorDataScreen:
        return MaterialPageRoute(builder: (context) => const AddFirestoreDataScreen());

      case RouteName.FetchFirestoreDataScreen:
        return MaterialPageRoute(builder: (context) => const FetchFirestoreDataScreen());

      case RouteName.UploadImageScreen:
        return MaterialPageRoute(builder: (context) => const UploadImageScreen());

      case RouteName.ForgetPasswordScreen:
        return MaterialPageRoute(builder: (context)=> const ForgetPasswordScreen());

        default:
        return MaterialPageRoute(builder: (context){
            return const Scaffold(
              body: Center(
                child: Text ('No Root Defined'),
              ),
            );
        });
    }

    }

}
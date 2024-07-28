import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xffFF0000),
        textColor: Color(0xffFEFEFE),
        fontSize: 16.0
    );

  }

}
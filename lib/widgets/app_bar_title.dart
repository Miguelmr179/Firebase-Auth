import 'package:flutter/material.dart';
import 'package:login/res/custom_colors.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/firebase.png',
        height: 20,),
        const SizedBox(width: 8.0,),
        Text('FlutterFile',
        style: TextStyle(
          color: Colorss.firebaseYellow,
          fontSize: 18
        ),
        ),
        Text("Authentication",
        style: TextStyle(
          color: Colorss.firebaseOrange,
          fontSize: 18,
        ),
        ),
        ],
    );
  }
}
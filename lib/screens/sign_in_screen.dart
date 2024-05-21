import 'package:login/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:login/utils/autentication.dart';
import 'package:login/widgets/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.firebaseNavy,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Row(),
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Image.asset('assets/firebase.png'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'FluterFire',
                      style: TextStyle(
                          color: Colorss.firebaseYellow,
                          fontSize: 40
                      ),
                    ),
                    Text(
                      'Autenticación',
                      style: TextStyle(
                          color: Colorss.firebaseOrange,
                          fontSize: 40
                      ),
                    )
                  ],
                ),
                ),
                FutureBuilder(future: Autentication.initializeFireBase(context: context), builder: (context, snapshot){
                  if(snapshot.hasError){
                    return const Text('Error inicianzo Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done){
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colorss.firebaseOrange),
                  );
                }),
              ],
            ),
          )),
    );
  }
}

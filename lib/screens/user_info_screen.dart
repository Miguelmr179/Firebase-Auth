import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/res/custom_colors.dart';
import 'package:login/screens/sign_in_screen.dart';
import 'package:login/widgets/app_bar_title.dart';
import 'package:login/utils/autentication.dart';

class UserInfoScreen extends StatefulWidget {
  final User _user;
  const UserInfoScreen({super.key, required User user})
      : _user = user;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSignInOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SignInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(-1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
              position: animation.drive(tween), child: child);
        });
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
    // Add code after super
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(),
            _user.photoURL != null
                ? ClipOval(
                    child: Material(
                      color: Colorss.firebaseGrey.withOpacity(0.3),
                      child: Image.network(
                        _user.photoURL!,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: Colorss.firebaseGrey.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colorss.firebaseGrey,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 16.0,
            ),
            const Text("Hola"),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              _user.displayName!,
              style: TextStyle(
                color: Colorss.firebaseYellow,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              '(${_user.email!})',
              style: TextStyle(
                color: Colorss.firebaseOrange,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              "Ahora ha iniciado sesion con su cuenta de Google"
              "Para Cerrar sesión haga clic en el boton Cerrar sesion"
              "Que aparece acontinuación",
              style: TextStyle(
                  color: Colorss.firebaseGrey.withOpacity(0.8),
                  fontSize: 14,
                  letterSpacing: 0.2),
            ),
            const SizedBox(
              height: 16,
            ),
            _isSignInOut
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      setState(() {
                        _isSignInOut = true;
                      });
                      await Autentication.singOut(context: context);
                      setState(() {
                        _isSignInOut = false;
                      });
                      Navigator.of(context)
                          .pushReplacement(_routeToSignInScreen());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ))
          ],
        ),
      )),
    );
  }
}

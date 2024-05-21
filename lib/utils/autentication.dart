import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/screens/user_info_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Autentication {
  static SnackBar customSnackBar({required String content}){
    return SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          content,
          style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
        ));
  }
  static Future<FirebaseApp> initializeFireBase({
    required BuildContext context,
}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => UserInfoScreen(
          user:user,
        ))
      );
    }
    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('La cuenta ya existe con una credencial diferente')));
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    "Se produjo un error al acceder a las credenciales. Intentar otra vez")));
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Se produjo un error al utilizar el inicio de sesion de Google. Intentar otra vez")));
        }
      }
    }
    return user;
  }
  static Future<void> singOut ({required BuildContext context}) async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      if(!kIsWeb){
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(Autentication.customSnackBar(content: 'Error al cerrar sesion. Intentar otra vez'));
    }
  }
}

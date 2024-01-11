import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

const USER_ID = 'USER_ID';
const USER_NAME = 'USER_NAME';
const USER_EMAIL = 'USER_EMAIL';
// const USER_PHONE = 'USER_PHONE';
const USER_IMG = 'USER_IMG';

class GoogleSignUpHelper {
  // final GoogleSignUp _googleSignUp = GoogleSignUp();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

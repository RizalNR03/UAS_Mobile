import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

const USER_ID = 'USER_ID';
const USER_NAME = 'USER_NAME';
const USER_EMAIL = 'USER_EMAIL';
// const USER_PHONE = 'USER_PHONE';
const USER_IMG = 'USER_IMG';

class GoogleSignInHelper {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future signInWithGoogle({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    EasyLoading.show(status: 'Signing out');
    // await _googleSignIn.signOut();
    await _auth.signOut();
    EasyLoading.dismiss();
  }

  bool isUserLoggedIn() {
    final user = _auth.currentUser;

    return user != null;
  }

  Future<User?> getUserData() async {
    return _auth.currentUser;
  }
}

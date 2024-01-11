import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  //SIGN UP METHOD
  Future<void> _signUp() async {
    try {
      final googleSignUpHelper = GoogleSignUpHelper();
      await googleSignUpHelper.signUp(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      // Tambahkan boolean untuk menentukan apakah data sudah benar atau tidak
      bool isDataCorrect = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Apakah Data Anda Sudah Benar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // Data belum benar
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true); // Data sudah benar
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );

      // Jika data sudah benar, kembali ke halaman login
      if (isDataCorrect == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    } catch (e) {
      print('Sign Up Failed: $e');
      _showErrorDialog('Terjadi kesalahan saat mendaftar. Silakan coba lagi.');
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 4,
              child: Container(
                width: 375,
                height: 727,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 280.0, 16.0, 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: _isObscure
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: _toggleVisibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 37,
              top: 0,
              child: Container(
                width: 301,
                height: 297,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/trip.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleSignUpHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Sign Up Failed: $e');
      throw e;
    }
  }
}

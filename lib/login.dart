import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts/signin_helper.dart';
import 'home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '', _passwd = ''; // Simpan username di sini
  double _imageSize = 301; // Ukuran awal gambar

  bool _isObscure = true;

  void _toggleVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _login() {
    // Logika login
    // Setelah login berhasil, arahkan ke halaman Home dengan mengirimkan username
    if (_username.isNotEmpty && _passwd.isNotEmpty) {
      EasyLoading.show(status: 'Mohon tunggu');

      GoogleSignInHelper()
          .signInWithGoogle(email: _username, password: _passwd)
          .then((value) async {
        if (value == null) {
          EasyLoading.showSuccess('Login sukses');

          await Future.delayed(Duration(seconds: 2));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(username: _username),
            ),
          );
        } else {
          EasyLoading.showError(value);
        }
      });
    }
  }

  void _toggleImageSize() {
    setState(() {
      _imageSize = _imageSize == 301 ? 150 : 301; // Toggle ukuran gambar
    });
  }

  void cekSession() async {
    var isLogin = GoogleSignInHelper().isUserLoggedIn();

    if (isLogin) {
      GoogleSignInHelper().getUserData().then((value) {
        print(value!.email.toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(username: value.email!),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 0,
              child: GestureDetector(
                onTap:
                    _toggleImageSize, // Panggil fungsi untuk mengubah ukuran gambar
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500), // Durasi animasi
                  width: _imageSize,
                  height: _imageSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/trip.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 300.0, 16.0, 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
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
                      onChanged: (value) {
                        setState(() {
                          _passwd = value;
                        });
                      },
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
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                    ),
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

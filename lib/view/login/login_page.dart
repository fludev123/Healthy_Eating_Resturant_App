import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controller/firebase_authentication.dart';
import '../../components/custom_app_bar.dart';
import '../user/homepage.dart';
import '../admin/admin_page.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthentication _authService = FirebaseAuthentication();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget buildTextField(String label, IconData icon, bool isPassword) {
    return TextField(
      controller: isPassword ? _passwordController : _emailController,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text("Enter valid email and password."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Healthy Eating", showCartIcon: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            SizedBox(height: 20.0),
            buildTextField('Username', Icons.person, false),
            buildTextField('Password', Icons.lock, true),
            SizedBox(height: 20.0),
            Container(
              height: 40,
              width: 100,
              child: ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                child: Text(
                  'LogIn',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  side: BorderSide(color: Colors.lightGreen, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'New user? ',
                  style: TextStyle(color: Colors.green),
                  children: [
                    TextSpan(
                      text: 'Register now',
                      style: TextStyle(color: Colors.lightGreen),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
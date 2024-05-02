import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controller/firebase_authentication.dart';
import '../../components/custom_app_bar.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  List<String> emailSuggestions = [
    'hint: xyz@gmail.com',
  ];

  List<String> passwordSuggestions = [
    'hint: Password should be 8 characters',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Healthy Eating", showCartIcon: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SignUp',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.green),
                onChanged: (text) {
                  setState(() {
                    emailSuggestions = _getSuggestions(text);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              //check that data is not already save
              if (emailSuggestions.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: emailSuggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(emailSuggestions[index]),
                        onTap: () {
                          emailController.text = emailSuggestions[index];
                          setState(() {
                            emailSuggestions = [];
                          });
                        },
                      );
                    },
                  ),
                ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.green),
                onChanged: (text) {
                  setState(() {
                    passwordSuggestions = _getPasswordSuggestions(text);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              if (passwordSuggestions.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: passwordSuggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(passwordSuggestions[index]),
                        onTap: () {
                          passwordController.text = passwordSuggestions[index];
                          setState(() {
                            passwordSuggestions = [];
                          });
                        },
                      );
                    },
                  ),
                ),
              SizedBox(height: 20.0),
              Container(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text(
                    'Create',
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
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getSuggestions(String query) {
    return emailSuggestions
        .where((suggestion) =>
        suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<String> _getPasswordSuggestions(String query) {
    return passwordSuggestions
        .where((suggestion) => suggestion.contains(query))
        .toList();
  }

  bool validateEmail() {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(emailController.text);
  }

  bool validatePassword() {
    return passwordController.text.length >= 8;
  }

  void signUp() async {
    if (!validateEmail()) {
      _showErrorDialog('Invalid Email', 'Please enter a valid email address.');
      return;
    }

    if (!validatePassword()) {
      _showErrorDialog(
          'Invalid Password', 'Password must be at least 8 characters long.');
      return;
    }

    try {
      await FirebaseAuthentication().signUp(
        emailController.text,
        passwordController.text,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Success',
              style: TextStyle(color: Colors.lightGreen, fontSize: 25),
            ),
            content: Text('Your account created successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.lightGreen, fontSize: 25),
                ),
              ),
            ],
          );
        },
      );

      emailController.clear();
      passwordController.clear();
    } catch (e) {
      _showErrorDialog('Authentication Error', 'Failed to sign up.');
      print('Error during sign-up: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ),
          ],
        );
      },
    );
  }
}
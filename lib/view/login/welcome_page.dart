import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_up_page.dart';
import '../../components/custom_app_bar.dart';

class WelcomePage extends StatelessWidget {
  Widget button({
    required String name,
    required Color color,
    required Color textColors,
    required VoidCallback onpressed,
  }) {
    return Container(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(
          name,
          style: TextStyle(color: textColors),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          side: BorderSide(color: Colors.green, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Healthy Eating", showCartIcon: false),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('images/logo.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Welcome To Healthy Eating",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(height: 20),
                  button(
                    name: 'Login',
                    color: Colors.lightGreen,
                    textColors: Colors.white,
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                  ),
                  SizedBox(height: 20),
                  button(
                      name: 'Sign Up',
                      color: Colors.white,
                      textColors: Colors.lightGreen,
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

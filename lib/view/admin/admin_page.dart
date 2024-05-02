import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import 'view_order.dart';
import 'manage_manue_page.dart';

class AdminPage extends StatelessWidget {
  Widget buildGenericButton(String buttonText, VoidCallback onPressed) {
    return Container(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.lightGreen,
          side: BorderSide(color: Colors.lightGreen, width: 2),
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
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/healthy_eating.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Admin',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(height: 60.0),
                  buildGenericButton('View Orders', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewOrder(),
                      ),
                    );
                  }),
                  SizedBox(height: 20.0),
                  buildGenericButton('Manage Menu', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageMenuPage(),
                      ),
                    );
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



import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import 'menupage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Healthy Eating", showCartIcon: true),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/healthy_eating.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Align(
                alignment: Alignment.center,

                child: ElevatedButton(

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  ),
                  child: Text("Go to Menu", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

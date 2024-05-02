import 'package:assignment_two/view/admin/view_manu_page.dart';
import 'package:flutter/material.dart';
import 'add_menu_page.dart';
import 'admin_page.dart';
import '../../components/custom_app_bar.dart';
import 'delete_menu_page.dart';

class ManageMenuPage extends StatelessWidget {
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
      appBar: CustomAppBar(title: "Manage Menu", showCartIcon: false),
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
                  buildGenericButton('View Menu', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewManuPage(),
                      ),
                    );
                  }),
                  SizedBox(height: 20.0),
                  buildGenericButton('Add Menu', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMenuPage(),
                      ),
                    );
                  }),
                  SizedBox(height: 20.0),
                  buildGenericButton('Delete Menu', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteMenuPage(),
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
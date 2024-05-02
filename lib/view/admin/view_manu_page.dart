
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../controller/firestoreservice.dart';

class ViewManuPage extends StatefulWidget {
   const ViewManuPage({super.key});

   @override
   State<ViewManuPage> createState() => _ViewManuPageState();
 }

class _ViewManuPageState extends State<ViewManuPage> {
  late List<Map<String, dynamic>> menus;

  @override
  void initState() {
    super.initState();
    // Initialize the menus list
    menus = [];
    // Call the function to fetch menus from Firestore
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    List<Map<String, dynamic>>? fetchedMenus = await FirestoreService().getMenus();
    if (fetchedMenus != null) {
      setState(() {
        menus = fetchedMenus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Manage Menu", showCartIcon: false),
      body: Column(
        children: [
          // Display the menus in a ListView
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(menus[index]['itemName'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Quantity: ${menus[index]['quantity']}, Price: ${menus[index]['price']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

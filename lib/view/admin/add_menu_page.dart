import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> addMenuToFirestore(
      String itemName, String quantity, double price, BuildContext context) async {
    try {
      // Create a reference to the 'menus' collection
      CollectionReference menus =
      FirebaseFirestore.instance.collection('menus');

      // Add a new document with a generated ID
      await menus.add({
        'itemName': itemName,
        'quantity': quantity,
        'price': price,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show a snackbar after successfully adding to Firestore
      final snackBar = SnackBar(
        content: Text('Menu added successfully!'),
        backgroundColor: Colors.lightGreen,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print('Error adding menu to Firestore: $e');
    }
  }
}

class AddMenuPage extends StatelessWidget {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Widget buildConfirmButton(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          String itemName = itemNameController.text;
          String quantity = quantityController.text;
          double price = double.parse(priceController.text);

          FirestoreService().addMenuToFirestore(
            itemName,
            quantity,
            price,
            context,
          );

          // Clear the text controllers after adding to Firestore
          itemNameController.clear();
          quantityController.clear();
          priceController.clear();
        },
        child: Text(
          'Add',
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
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.0),
                Text(
                  'Add Menu',
                  style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // TextFormFields
                TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(labelText: 'Item Name'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(height: 20.0),
                // Confirm button
                buildConfirmButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

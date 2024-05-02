import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../controller/firestoreservice.dart';


class DeleteMenuPage extends StatelessWidget {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  Widget buildConfirmButton(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      child: ElevatedButton(
        onPressed: () async {
          String itemName = itemNameController.text.trim();
          String quantity = quantityController.text.trim();
          double price = double.tryParse(priceController.text.trim()) ?? 0.0;

          try {
            await firestoreService.deleteMenu(itemName, quantity, price);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Menu deleted successfully!'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.lightGreen,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$e'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Text(
          'Delete',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.0),
              Text(
                'Delete Menu',
                style: TextStyle(color: Colors.lightGreen, fontSize: 24, fontWeight: FontWeight.bold),
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
    );
  }
}
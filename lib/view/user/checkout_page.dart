import 'package:assignment_two/view/admin/admin_login.dart';
import 'package:assignment_two/view/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controller/cart_provider.dart';
import '../../model/cart_item.dart';
import '../../components/custom_app_bar.dart';


class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: "Checkout", showCartIcon: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Display a summary of items in the cart
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                CartItem cartItem = cartProvider.cartItems[index];
                return ListTile(
                  title: Text(cartItem.itemName),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text(
                    'Price: ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Total: ${cartProvider.getTotalCost().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              child: Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//order in firebase firestore
  void _placeOrder() async {
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (_validateInputs()) {

      CollectionReference orders = FirebaseFirestore.instance.collection('orders');
      await orders.add({
        'name': nameController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'items': _getCartItems(cartProvider.cartItems),
        'totalCost': cartProvider.getTotalCost(),
        'timestamp': FieldValue.serverTimestamp(), // Optional: Store the order timestamp
      });

      // Clear the cart after placing the order
      cartProvider.clearCart();

      // Show order confirmation dialog
      showOrderConfirmation();
    } else {
      _showErrorDialog();
    }
  }

  List<Map<String, dynamic>> _getCartItems(List<CartItem> cartItems) {
    return cartItems.map((cartItem) => {
      'itemName': cartItem.itemName,
      'quantity': cartItem.quantity,
      'price': cartItem.price,
    }).toList();
  }

  bool _validateInputs() {
    return nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all the required fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.lightGreen),
              ),
            ),
          ],
        );
      },
    );
  }

  void showOrderConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Placed'),
          content: Text('Thank you for your order!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLogin(),));
                /*Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);*/
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.lightGreen),
              ),
            ),
          ],
        );
      },
    );
  }

}

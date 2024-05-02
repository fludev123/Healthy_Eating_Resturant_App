import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/cart_provider.dart';
import '../../model/cart_item.dart';
import '../../components/custom_app_bar.dart';
import 'checkout_page.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: "Order Summary"),
      body: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          CartItem cartItem = cartProvider.cartItems[index];
          return ListTile(
            title: Text(cartItem.itemName),
            subtitle: Text('Quantity: ${cartItem.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Price: ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {
                    cartProvider.removeFromCart(cartItem.itemName);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.lightGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: ${cartProvider.getTotalCost().toStringAsFixed(2)}'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white) ,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              child: Text('Place Order',style: TextStyle(color: Colors.lightGreen),),
            ),
          ],
        ),
      ),
    );
  }
}

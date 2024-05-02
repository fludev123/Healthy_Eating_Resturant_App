import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_provider.dart';
import '../view/user/orderPage.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) => Stack(
        children: [
          IconButton(
            icon: Icon(Icons.shopping_cart,size: 30,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage()),
              );
            },
          ),
          if (cartProvider.cartItems.isNotEmpty)
            Positioned(
              right: 6,
              top: 6,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 7,
                child: Text(
                  cartProvider.cartItems.length.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

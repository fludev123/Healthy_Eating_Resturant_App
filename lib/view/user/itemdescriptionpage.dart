import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/cart_provider.dart';
import 'orderPage.dart';
import '../../components/custom_app_bar.dart';

class ItemDescriptionPage extends StatelessWidget {
  final String itemName;
  final String imagePath;
  final String description;
  final double price;

  ItemDescriptionPage({
    required this.itemName,
    required this.imagePath,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    // To get the current quantity from the CartProvider
    int currentQuantity = cartProvider.getQuantity(itemName);

    return Scaffold(
      appBar: CustomAppBar(title: "Item Name", showCartIcon: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath,
                  height: 200, width: 250, fit: BoxFit.cover),
              SizedBox(height: 20),
              Text(
                itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Price: ${price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (currentQuantity > 0) {
                        cartProvider.reduceQuantity(itemName);
                      }
                    },
                  ),
                  Text('$currentQuantity'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cartProvider.addToCart(itemName, price);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the order page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to get dynamic description for each item
String getDescriptionForItem(String itemName) {
  switch (itemName) {
    case "Chicken Noodles Soup":
      return "Delicious chicken noodles soup with fresh vegetables.";
    case "Chicken Bites":
      return "Crispy and flavorful chicken bites, perfect for snacking.";
    case "Momos":
      return "Authentic wheat chicken momos served with spicy sauce.";
    case "Loaded Fries":
      return "Irresistible loaded fries topped with cheese and bacon.";
    case "Pepperoni Pizza":
      return "Classic pepperoni pizza with a perfect blend of flavors.";
    case "Coffee":
      return "Aromatic and rich coffee to complement your meal.";
    case "Ice Cream":
      return "Creamy raspberry ice cream for a delightful dessert.";
    default:
      return "No description available.";
  }
}

// Function to get dynamic price for each item
double getPriceForItem(String itemName) {
  switch (itemName) {
    case "Chicken Noodles Soup":
      return 850;
    case "Chicken Bites":
      return 1200;
    case "Momos":
      return 1000;
    case "Loaded Fries":
      return 750;
    case "Pepperoni Pizza":
      return 2000;
    case "Coffee":
      return 600;
    case "Ice Cream":
      return 550;
    default:
      return 0.0;
  }
}

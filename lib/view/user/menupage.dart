import 'package:flutter/material.dart';
import '../../components/custom_app_bar.dart';
import 'itemdescriptionpage.dart';
import 'package:provider/provider.dart';


class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Menu", showCartIcon: true),
        body: Row(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(25.0),
                children: [
                  PizzaCard(itemName: "Chicken Noodles Soup", imagePath: "images/chicken_noodle_soup.jpg"),
                  SizedBox(height: 20.0),
                  PizzaCard(itemName: "Chicken Bites", imagePath: "images/chicken_bites.jpeg"),
                  SizedBox(height: 20.0),
                  PizzaCard(itemName: "Momos", imagePath: "images/wheat_chicken_momos.webp"),
                  SizedBox(height: 20.0),
                  PizzaCard(itemName: "Loaded Fries", imagePath: "images/loaded_fries.jpg"),
                  SizedBox(height: 20.0),
                  PizzaCard(itemName: "Pepperoni Pizza", imagePath: "images/Pepperoni_pizza.jpg"),
                  SizedBox(height: 20.0),
                  PizzaCard(itemName: "Coffee", imagePath: "images/coffee.webp"),
                  SizedBox(height: 20.0),
                  PizzaCard(itemName: "Ice Cream", imagePath: "images/raspberry_ice_cream.jpg"),

                ],
              ),
            )
          ],

        )
    );
  }
}


class PizzaCard extends StatelessWidget {

  final String itemName;
  final String imagePath;

  const PizzaCard({required this.itemName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    //CartProvider cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        //cartProvider.addToCart(itemName, getPriceForItem(itemName));
        // Navigate to the item description page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDescriptionPage(
              itemName: itemName,
              imagePath: imagePath,
              description: getDescriptionForItem(itemName),
              price: getPriceForItem(itemName),
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        color: Colors.white30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(imagePath,height: 200, width: 250, fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(itemName,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}
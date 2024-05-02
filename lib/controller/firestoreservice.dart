import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //view orders
  Future<List<Map<String, dynamic>>?> getOrdersSortedByTimestamp() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> orders = querySnapshot.docs
          .map((DocumentSnapshot document) => document.data() as Map<String, dynamic>)
          .toList();

      return orders;
    } catch (e) {
      print('Error getting orders: $e');
      return null;
    }
  }

  Future<void> addMenuToFirestore(String itemName, String quantity, double price) async {
    try {

      CollectionReference menus = FirebaseFirestore.instance.collection('menus');

      await menus.add({
        'itemName': itemName,
        'quantity': quantity,
        'price': price,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      });
    } catch (e) {
      print('Error adding menu to Firestore: $e');
    }
  }

  Future<void> deleteMenu(String itemName, String quantity, double price) async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('menus')
          .where('itemName', isEqualTo: itemName)
          .where('quantity', isEqualTo: quantity)
          .where('price', isEqualTo: price)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Data exists, delete it
        await FirebaseFirestore.instance.collection('menus').doc(querySnapshot.docs.first.id).delete();
      } else {
        // Data not found
        throw Exception('Menu not found in Firestore!');
      }
    } catch (e) {
      print('Error deleting menu from Firestore: $e');
      rethrow; // Re-throw the exception for handling in the UI
    }
   //get orders
    Future<List<Map<String, dynamic>>?> getOrdersSortedByTimestamp({String? searchQuery}) async {
      try {
        Query collectionReference = FirebaseFirestore.instance.collection('orders');

        if (searchQuery != null && searchQuery.isNotEmpty) {
          // Apply a filter based on the search query
          collectionReference = collectionReference.where('itemName', isEqualTo: searchQuery);
        }

        QuerySnapshot querySnapshot = await collectionReference
            .orderBy('timestamp', descending: true)
            .get();

        List<Map<String, dynamic>> orders = querySnapshot.docs
            .map((DocumentSnapshot document) => document.data() as Map<String, dynamic>)
            .toList();

        return orders;
      } catch (e) {
        print('Error getting orders: $e');
        return null;
      }
    }

  }
//get the Menus from firebase firestore
  Future<List<Map<String, dynamic>>?> getMenus() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('menus')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> menus = querySnapshot.docs
          .map((DocumentSnapshot document) => document.data() as Map<String, dynamic>)
          .toList();

      return menus;
    } catch (e) {
      print('Error getting menus: $e');
      return null;
    }
  }




}



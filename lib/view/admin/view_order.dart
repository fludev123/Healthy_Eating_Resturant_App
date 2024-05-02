// Import necessary packages
import 'package:flutter/material.dart';
import '../../controller/firestoreservice.dart';
import '../../components/custom_app_bar.dart';


class ViewOrder extends StatefulWidget {
  const ViewOrder({Key? key}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  final FirestoreService _firestoreService = FirestoreService();
  late List<Map<String, dynamic>> orders;

  @override
  void initState() {
    super.initState();
    orders = [];
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    List<Map<String, dynamic>>? data = await _firestoreService.getOrdersSortedByTimestamp();
    setState(() {
      orders = data ?? [];
    });
  }

  void _deleteItem(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Healthy Eating", showCartIcon: false),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>?>(
          future: _firestoreService.getOrdersSortedByTimestamp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Name: ${orders[index]['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address: ${orders[index]['address']}'),
                        Text('Phone: ${orders[index]['phone']}'),
                        Text('Item: ${orders[index]['item']}'),
                        Text('TotalCost: ${orders[index]['totalCost']}'),
                        Text('Timestamp: ${orders[index]['timestamp']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () {
                        _deleteItem(index);
                      },
                    ),
                  );
                },
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}

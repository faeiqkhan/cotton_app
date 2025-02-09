import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_details_screen.dart';
import 'auth_service.dart';

class BuyerDashboard extends StatefulWidget {
  @override
  _BuyerDashboardState createState() => _BuyerDashboardState();
}

class _BuyerDashboardState extends State<BuyerDashboard> {
  List<Map<String, dynamic>> listings = [];

  @override
  void initState() {
    super.initState();
    fetchListings();
  }

  Future<void> fetchListings() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.11:5000/listings'));

      if (response.statusCode == 200) {
        setState(() {
          listings = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        throw Exception('Failed to load listings');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => AuthService.logout(context), // Logout function
          ),
        ],
      ),
      body: listings.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: listings.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(listings[index]['variety']),
                    subtitle: Text("Weight: ${listings[index]['weight']} kg\nPrice: ₹${listings[index]['price']} per kg\nSeller: ${listings[index]['sellerEmail']}"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
                    },
                  ),
                );
              },
            ),
    );
  }
}

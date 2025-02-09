import 'package:flutter/material.dart';
import 'negotiation_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shankar-6 Cotton', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Vendor: ABC Cotton Traders'),
            Text('Bale Weight: 170 Kg'),
            Text('Price: ₹50,000 per ton'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NegotiationScreen()));
              },
              child: Text('Negotiate Price'),
            ),
          ],
        ),
      ),
    );
  }
}

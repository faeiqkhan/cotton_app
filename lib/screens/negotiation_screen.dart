import 'package:flutter/material.dart';

class NegotiationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Negotiate')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Enter Your Offer Price')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Submit Offer')),
            SizedBox(height: 20),
            Text('Negotiation Details'),
            SizedBox(height: 20),
            Text('Negotiation History'),
            SizedBox(height: 20),
            Text('Negotiation Status'), 
            SizedBox(height: 20),
            Text('Negotiation Result'), 
            SizedBox(height: 20),
            Text('Accept Negotiation'),
            SizedBox(height: 20),
            Text('Decline Negotiation'),  
          ],

              
        ),
      ),
    );
  }
}

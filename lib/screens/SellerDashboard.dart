import 'package:flutter/material.dart';
import 'auth_service.dart';

class SellerDashboard extends StatefulWidget {
  final String sellerEmail;

  SellerDashboard({required this.sellerEmail});

  @override
  _SellerDashboardState createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  String? selectedVariety;
  String? selectedQuality;
  String? selectedState;

  final TextEditingController micronaireController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController strengthController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  final List<String> cottonVarieties = [
    "Sanju hybrid", "Shankar 6", "Shankar 8", "Desi Gujarat 23", "Desi Sarthi",
    "Unknown Bt", "Rakshak", "NB 151", "NB 151-F2", "Mahyco 162", "Mahyco 12"
  ];

  final List<String> qualityOptions = ["Low", "Medium", "High", "Premium"];
  final List<String> states = ["Maharashtra", "Gujarat", "Madhya Pradesh", "Rajasthan", "Punjab"];

  List<Map<String, dynamic>> listings = [];

  void addListing() {
    if (selectedVariety != null &&
        selectedQuality != null &&
        micronaireController.text.isNotEmpty &&
        lengthController.text.isNotEmpty &&
        strengthController.text.isNotEmpty &&
        selectedState != null &&
        cityController.text.isNotEmpty &&
        distanceController.text.isNotEmpty &&
        minPriceController.text.isNotEmpty &&
        maxPriceController.text.isNotEmpty) {
      
      setState(() {
        listings.add({
          'Variety': selectedVariety!,
          'Quality': selectedQuality!,
          'Micronaire': micronaireController.text,
          'Length': lengthController.text,
          'Strength': strengthController.text,
          'State': selectedState!,
          'City': cityController.text,
          'Distance': distanceController.text,
          'Price Range': "₹${minPriceController.text} - ₹${maxPriceController.text}",
        });

        selectedVariety = null;
        selectedQuality = null;
        micronaireController.clear();
        lengthController.clear();
        strengthController.clear();
        selectedState = null;
        cityController.clear();
        distanceController.clear();
        minPriceController.clear();
        maxPriceController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Listing Added!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => AuthService.logout(context), // Logout
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Cotton Bale Listing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: selectedVariety,
                decoration: InputDecoration(
                  labelText: "Select Variety",
                  border: OutlineInputBorder(),
                ),
                items: cottonVarieties.map((String variety) {
                  return DropdownMenuItem<String>(
                    value: variety,
                    child: Text(variety),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedVariety = newValue;
                  });
                },
              ),

              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: selectedQuality,
                decoration: InputDecoration(
                  labelText: "Select Quality",
                  border: OutlineInputBorder(),
                ),
                items: qualityOptions.map((String quality) {
                  return DropdownMenuItem<String>(
                    value: quality,
                    child: Text(quality),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedQuality = newValue;
                  });
                },
              ),

              SizedBox(height: 10),
              TextField(
                controller: micronaireController,
                decoration: InputDecoration(labelText: "Micronaire", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              TextField(
                controller: lengthController,
                decoration: InputDecoration(labelText: "Length (mm)", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              TextField(
                controller: strengthController,
                decoration: InputDecoration(labelText: "Strength (g/tex)", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: InputDecoration(
                  labelText: "Select State",
                  border: OutlineInputBorder(),
                ),
                items: states.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                },
              ),

              SizedBox(height: 10),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: "City", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              TextField(
                controller: distanceController,
                decoration: InputDecoration(labelText: "Distance (km)", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minPriceController,
                      decoration: InputDecoration(labelText: "Min Price", border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: maxPriceController,
                      decoration: InputDecoration(labelText: "Max Price", border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: addListing,
                child: Text("Add Listing"),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              ),
              SizedBox(height: 20),

              Text("Your Listings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              listings.isEmpty
                  ? Center(child: Text("No listings added yet."))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listings.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(listings[index]['Variety']!),
                            subtitle: Text(
                                "Quality: ${listings[index]['Quality']}\n"
                                "Micronaire: ${listings[index]['Micronaire']}\n"
                                "Length: ${listings[index]['Length']} mm\n"
                                "Strength: ${listings[index]['Strength']} g/tex\n"
                                "Location: ${listings[index]['City']}, ${listings[index]['State']}\n"
                                "Distance: ${listings[index]['Distance']} km\n"
                                "Price Range: ${listings[index]['Price Range']}"),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

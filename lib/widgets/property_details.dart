import 'package:airbnb/widgets/book_property.dart';
import 'package:flutter/material.dart';
import 'package:airbnb/theme.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Map<String, dynamic> property;

  PropertyDetailsPage({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          property['name'] ?? 'Property Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              property['images'][0] ?? "https://via.placeholder.com/300",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property['name'] ?? "No Title",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 4),
                      Text(
                        "${property['city'] ?? 'Unknown Location'}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    property['description'] ?? "A beautiful and cozy stay with all modern amenities. Enjoy a relaxing vacation with breathtaking views, top-notch hospitality, and complete convenience.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Rating: ⭐${property['rating'] ?? 4.5} / 5",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Amenities:",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Free Wi-Fi\n• Air Conditioning\n• Kitchen\n• Pool\n• Parking\n• 24/7 Security\n• Pet Friendly",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${property['price']} per night",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
             onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(property: property),
                    )
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: Text(
                "Book Now",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:airbnb/theme.dart';
import 'package:flutter/material.dart';
import 'package:airbnb/widgets/confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EssentialItem {
  final String name;
  final String imagePath;
  final double price;
  bool isSelected;

  EssentialItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.isSelected = false,
  });
}

class EssentialSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> property;
  final DateTime selectedDate;

  EssentialSelectionScreen(
      {required this.property, required this.selectedDate});

  @override
  _EssentialSelectionScreenState createState() =>
      _EssentialSelectionScreenState();
}

class _EssentialSelectionScreenState extends State<EssentialSelectionScreen> {
  List<EssentialItem> items = [
    EssentialItem(
        name: "Milk", imagePath: "assets/images/milk.png", price: 30.0),
    EssentialItem(
        name: "Tissue", imagePath: "assets/images/tissue.png", price: 60.0),
    EssentialItem(
        name: "Bread", imagePath: "assets/images/bread.png", price: 25.0),
    EssentialItem(
        name: "Butter", imagePath: "assets/images/butter.png", price: 60.0),
    EssentialItem(
        name: "Coke", imagePath: "assets/images/coke.png", price: 50.0),
    EssentialItem(
        name: "Toothpaste",
        imagePath: "assets/images/toothpaste.png",
        price: 40.0),
    EssentialItem(
        name: "Lays", imagePath: "assets/images/lays.png", price: 20.0),
    EssentialItem(
        name: "Lays", imagePath: "assets/images/lays2.png", price: 20.0),
    EssentialItem(
        name: "Eggs", imagePath: "assets/images/eggs.png", price: 50.0),
    EssentialItem(
        name: "Maggi", imagePath: "assets/images/maggi.png", price: 15.0),
    EssentialItem(
        name: "Wet Wipes", imagePath: "assets/images/wipes.png", price: 90.0),
    EssentialItem(
        name: "Nutella", imagePath: "assets/images/nutella.png", price: 300.0),
  ];

  double get totalAmount {
    return items
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + item.price);
  }

  Future<void> _confirmBooking() async {
    final selectedItems = items
        .where((item) => item.isSelected)
        .map((item) => {'name': item.name, 'price': item.price})
        .toList();

    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'userId': widget.property['userId'],
        'name': widget.property['name'],
        'city': widget.property['city'],
        'price': widget.property['price'],
        'date': widget.selectedDate.toIso8601String(),
        'requestedItems': selectedItems,
        'essentialsTotal': totalAmount,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BookingConfirmedScreen(property: widget.property),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Essentials", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Select items to be available on arrival",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap:
                  true, // Makes the grid scrollable inside the single scroll view
              physics:
                  NeverScrollableScrollPhysics(), // Disable internal scrolling
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        item.isSelected = !item.isSelected;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: item.isSelected
                              ? primaryColor
                              : const Color.fromARGB(255, 224, 215, 215),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item.imagePath, height: 125),
                          const SizedBox(height: 10),
                          Text("${item.name} ₹${item.price.toStringAsFixed(0)}",
                              style: Theme.of(context).textTheme.bodyMedium),
                          if (item.isSelected)
                            Icon(Icons.check_circle, color: primaryColor),
                        ],
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total: ₹${totalAmount.toStringAsFixed(0)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: primaryColor, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: _confirmBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                "Proceed",
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

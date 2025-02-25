import 'package:flutter/material.dart';
import '../widgets/category.dart';
import '../widgets/property_card.dart';
import '../theme.dart';
import 'search_screen.dart';
// import '../api_services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                ),
                child: SearchBar(),
              ),
            ),
            const SizedBox(height: 20),
            CategoryTabs(),
            Expanded(child: PropertyList()),
          ],
        ),
      ),
    );
  }
}

// ------------------ SEARCH BAR ------------------ //
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black54),
          SizedBox(width: 8),
          Text("Start your search",
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  final List<Map<String, dynamic>> hardcodedProperties = [
  {
    "name": "Luxury Villa in Bali",
    "city": "Bali",
    "images": [
      "https://a0.muscache.com/im/pictures/979a0745-e0cf-41c8-8643-b1f647df140a.jpg?im_w=720"
    ],
    "price": "₹8,000"
  },
  {
    "name": "Cozy Apartment in Paris",
    "city": "Paris",
    "images": [
      "https://a0.muscache.com/im/pictures/hosting/Hosting-949178357822527152/original/65fbccbf-9397-4923-a2d4-805c3ea40594.jpeg?im_w=720"
    ],
    "price": "₹5,500"
  },
  {
    "name": "Modern Condo in New York",
    "city": "New York",
    "images": [
      "https://a0.muscache.com/im/pictures/8f2cddd4-7add-4640-9ed9-7033a01dd63d.jpg?im_w=720"
    ],
    "price": "₹10,000"
  },
  {
    "name": "Beach House in Maldives",
    "city": "Maldives",
    "images": [
      "https://a0.muscache.com/im/pictures/miso/Hosting-33143551/original/2ae34b82-5b72-435a-af81-1701d046d89e.jpeg?im_w=720"
    ],
    "price": "₹15,000"
  },
  {
    "name": "Traditional Ryokan in Japan",
    "city": "Kyoto",
    "images": [
      "https://a0.muscache.com/im/pictures/09bcab27-4e07-42f3-a266-ba9716dec1aa.jpg?im_w=720"
    ],
    "price": "₹7,200"
  }
];

@override
Widget build(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    itemCount: hardcodedProperties.length,
    itemBuilder: (context, index) {
      return PropertyCard(property: hardcodedProperties[index]);
    },
  );
}

}

import 'package:flutter/material.dart';
import '../theme.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search", style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: greyColor),
                hintText: "Search destinations",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            Expanded(child: SuggestedDestinations()),

            FilterButton(label: "When", value: "Any week", icon: Icons.calendar_today),
            SizedBox(height: 8),
            FilterButton(label: "Who", value: "Add guests", icon: Icons.person),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Clear all", style: TextStyle(color: darkgrey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text("Search", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class SuggestedDestinations extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {"name": "Lonavala, Maharashtra", "desc": "For sights like Karla Caves", "image": "assets/images/lonavala.png"},
    {"name": "North Goa, Goa", "desc": "Popular beach destination", "image": "assets/images/goa.png"},
    {"name": "Alibag, Maharashtra", "desc": "Near you", "image": "assets/images/alibag.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, 
      physics: NeverScrollableScrollPhysics(), 
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final place = destinations[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                place["image"]!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(place["name"]!, style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text(place["desc"]!, style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const FilterButton(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: darkgrey),
              SizedBox(width: 8),
              Text(label, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

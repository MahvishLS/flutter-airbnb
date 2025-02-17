import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Amazing views", "icon": "assets/icons/airbnb_views.jpg"},
    {"name": "Beach", "icon": "assets/icons/airbnb_beach.jpg"},
    {"name": "Amazing pools", "icon": "assets/icons/airbnb_pool.jpg"},
    {"name": "Farms", "icon": "assets/icons/airbnb_farm.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: categories.map((category) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Image.asset(
                  category["icon"]!,
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 4),
                Text(category["name"]!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

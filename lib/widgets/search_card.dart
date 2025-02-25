import 'package:flutter/material.dart';
import 'package:airbnb/theme.dart';

class SearchCard extends StatefulWidget {
  final Map<String, dynamic> property;

  SearchCard({required this.property});

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Extracting required data from the JSON
    String title = widget.property['listing']['title'] ?? "No Title";
    String firstImageUrl = (widget.property['listing']['contextualPictures'] != null &&
            widget.property['listing']['contextualPictures'].isNotEmpty)
        ? widget.property['listing']['contextualPictures'][0]['picture']
        : "https://via.placeholder.com/300";
    String price = widget.property['pricingQuote']['structuredStayDisplayPrice']['primaryLine']['discountedPrice'] ?? "N/A";

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Image.network(
                  firstImageUrl,
                  width: double.infinity,
                  height: 235,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 4),
                Text("₹$price per night", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  ),
                  child: Text(
                    "View",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

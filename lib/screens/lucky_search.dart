import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:airbnb/theme.dart';

class LuckySearchCard extends StatefulWidget {
  @override
  _LuckySearchCardState createState() => _LuckySearchCardState();
}

class _LuckySearchCardState extends State<LuckySearchCard> {
  Map<String, dynamic>? selectedProperty;

  @override
  void initState() {
    super.initState();
    _loadAndSelectRandomProperty();
  }

  Future<void> _loadAndSelectRandomProperty() async {
    try {
      String jsonString = await rootBundle.loadString('assets/new.json');
      List<dynamic> jsonData = json.decode(jsonString);

      if (jsonData.isNotEmpty) {
        setState(() {
          selectedProperty = jsonData[Random().nextInt(jsonData.length)];
        });
      }
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedProperty == null) {
      return const Center(child: CircularProgressIndicator());
    }

    String title = selectedProperty?['listing']?['name'] ?? "No Title";
    List<dynamic>? images = selectedProperty?['listing']?['contextualPictures'];
    String firstImageUrl = (images != null && images.isNotEmpty)
        ? images[0]['picture']
        : "https://via.placeholder.com/300";

    String price = selectedProperty?['pricingQuote']
                ?['structuredStayDisplayPrice']?['primaryLine']
            ?['discountedPrice'] ??
        "\$59";

    String city = selectedProperty?['listing']?['localizedCityName'] ?? "Unknown City";
    String rating = selectedProperty?['listing']?['avgRatingLocalized'] ?? "No rating";
    String beds = images?.firstWhere(
            (pic) => pic['caption'] != null && pic['caption']['messages'] != null,
            orElse: () => {})?['caption']['messages']?.join(', ') ??
        "No details";

    bool isGuestFavorite = selectedProperty?['listing']?['formattedBadges']
            ?.any((badge) => badge['text'] == "Guest favorite") ??
        false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 35.0),
          Text(
            "I'm Feeling Lucky ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.network(
                        firstImageUrl,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      if (isGuestFavorite)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Guest Favorite",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 7),
                      Text(city, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 7),
                      Text("⭐ $rating", style: const TextStyle(color: Colors.orange)),
                      const SizedBox(height: 7),
                      Text(beds, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Text("$price per night",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
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
          ),
        ],
      ),
    );
  }
}

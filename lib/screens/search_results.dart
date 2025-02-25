import 'package:airbnb/api_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../theme.dart';
import '../widgets/search_card.dart';

class SearchResultsPage extends StatefulWidget {
  final String location;
  final DateTime? selectedDate;
  final int adults;
  final int children;
  final int infants;
  final int pets;

  const SearchResultsPage({
    super.key,
    required this.location,
    this.selectedDate,
    required this.adults,
    required this.children,
    required this.infants,
    required this.pets,
  });

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final AirbnbService _airbnbService = AirbnbService();
  List<dynamic> _listings = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }  Future<void> _fetchListings() async {
    try {
      List<dynamic> listings =
          await _airbnbService.searchProperties(widget.location);
      setState(() {
        _listings = listings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results for ${widget.location}")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child:
                      Text(_errorMessage!, style: TextStyle(color: Colors.red)))
              : _listings.isEmpty
                  ? Center(child: Text("No results found."))
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _listings.length,
                      itemBuilder: (context, index) {
                        return SearchCard(property: _listings[index]);
                      },
                    ),
    );
  }
}



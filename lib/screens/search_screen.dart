import 'package:flutter/material.dart';
import 'package:airbnb/screens/search_results.dart';
import '../theme.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentStep = 0;
  String location = "";
  DateTime? selectedDate;
  int adults = 1;
  int children = 0;
  int infants = 0;
  int pets = 0;

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        _searchProperties();
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) _currentStep--;
    });
  }

  void _searchProperties() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          location: location,
          selectedDate: selectedDate,
          adults: adults,
          children: children,
          infants: infants,
          pets: pets,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _currentStep == 0
                  ? _buildLocationStep()
                  : _currentStep == 1
                      ? _buildDateStep()
                      : _buildGuestsStep(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  TextButton(
                    onPressed: _previousStep,
                    child: Text("Back", style: myTextTheme.bodyMedium),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: _nextStep,
                  child: Text(
                    _currentStep == 2 ? "Search" : "Next",
                    style: myTextTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Where are you going?", style: myTextTheme.displayMedium),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) => location = value,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: greyColor),
            hintText: "Search destinations",
          ),
        ),
         const SizedBox(height: 16),
         Expanded(child: SuggestedDestinations()),
      ],
    );
  }

  Widget _buildDateStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("When's your trip?", style: myTextTheme.displayMedium),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() => selectedDate = pickedDate);
            }
          },
          child: Text(
            selectedDate == null ? "Select Date" : selectedDate!.toLocal().toString().split(' ')[0],
          ),
        ),
      ],
    );
  }

  Widget _buildGuestsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Who's coming?", style: myTextTheme.displayMedium),
        const SizedBox(height: 16),
        _guestCounter("Adults", adults, (val) => setState(() => adults = val)),
        _guestCounter("Children", children, (val) => setState(() => children = val)),
        _guestCounter("Infants", infants, (val) => setState(() => infants = val)),
        _guestCounter("Pets", pets, (val) => setState(() => pets = val)),
      ],
    );
  }

  Widget _guestCounter(String label, int count, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: myTextTheme.bodyLarge),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: count > 0 ? () => onChanged(count - 1) : null,
            ),
            Text("$count", style: myTextTheme.bodyLarge),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => onChanged(count + 1),
            ),
          ],
        ),
      ],
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
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final place = destinations[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
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

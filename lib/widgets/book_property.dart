import 'package:airbnb/widgets/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:airbnb/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> property;

  BookingScreen({required this.property});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController _dateController = TextEditingController();
    List<TextEditingController> _requestControllers = [];
  DateTime? _selectedDate;
  String? _userId;

  void initState() {
    _fetchUserId();
    super.initState();
    _requestControllers.add(TextEditingController());
    _requestControllers.add(TextEditingController());
  }


  @override
  void dispose() {
    _dateController.dispose();
    for (var controller in _requestControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addRequestField() {
    setState(() {
      _requestControllers.add(TextEditingController());
    });
  }


  /// Fetch the current logged-in user ID
  void _fetchUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }


  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _confirmBooking() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a travel date")),
      );
      return;
    }

    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in!")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'userId': _userId,
        'name': widget.property['name'],
        'city': widget.property['city'],
        'price': widget.property['price'],
        'date': _dateController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BookingConfirmedScreen(property: widget.property),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to book: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.property['name'] ?? "No Title",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8),
              Text(
                "Location: ${widget.property['city'] ?? 'Unknown Location'}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8),
              Text(
                "Price: ${widget.property['price']} per night",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),

              // Travel Date Picker
              Text("Travel Date:", style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 8),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select Date",
                  suffixIcon: Icon(Icons.calendar_today, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: _selectDate,
              ),
              const SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true, 
                physics: NeverScrollableScrollPhysics(), 
                itemCount: _requestControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextField(
                      controller: _requestControllers[index],
                      decoration: InputDecoration(
                        hintText: "Enter request",
                        hintStyle: const TextStyle(color: greyColor),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: darkgrey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: darkgrey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: IconButton(
                  onPressed: _addRequestField,
                  icon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.add_circle, color: primaryColor, size: 56),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  ),
                  child: Text(
                    "Confirm Booking",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

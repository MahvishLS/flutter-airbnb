import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> fetchBookings() async {
    User? user = _auth.currentUser;
    if (user == null) return [];
    
    QuerySnapshot snapshot = await _firestore
        .collection('bookings')
        .where('userId', isEqualTo: user.uid)
        .get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookings found", style: bodyTextStyle));
          }
          
          List<DocumentSnapshot> bookings = snapshot.data!;
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  title: Text(booking['name'] ?? 'Booking', style: headingStyle.copyWith(color: primaryColor)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City: ${booking['city'] ?? 'Unknown'}", style: bodyTextStyle),
                      Text("Date: ${booking['date'] ?? 'No Date'}", style: bodyTextStyle),
                      Text("Price: ${booking['price'] ?? 'N/A'}", style: bodyTextStyle),
                      Text("Extra Items: ${booking['essentialsTotal'] ?? 'N/A'}", style: bodyTextStyle),
                    ],
                  )
                ),
              );
            },
          );
        },
      ),
    );
  }
}

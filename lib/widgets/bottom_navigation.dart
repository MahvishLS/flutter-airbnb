// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Theme.of(context).colorScheme.primary,
//       unselectedItemColor: Colors.grey,
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
//         BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlists"),
//         BottomNavigationBarItem(icon: Icon(Icons.airplanemode_active), label: "Trips"),
//         BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//       ],
//     );
//   }
// }

import 'package:airbnb/screens/home_page.dart';
import 'package:airbnb/screens/profile_screen.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(body: Center(child: Text("Wishlists"))), 
    Scaffold(body: Center(child: Text("Trips"))),
    Scaffold(body: Center(child: Text("Messages"))), 
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlists"),
          BottomNavigationBarItem(icon: Icon(Icons.airplanemode_active), label: "Trips"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

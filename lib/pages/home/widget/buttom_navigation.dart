import 'package:event_booking/pages/calendar/calendart.dart';
import 'package:event_booking/pages/home/homepage.dart';
import 'package:event_booking/pages/maps/navigation.dart';
import 'package:event_booking/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatefulWidget {
  const ButtomNavigation({required Key key}) : super(key: key);

  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CalendarPage(),
    NavigationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 76, 37, 205),
        onPressed: () {
          Navigator.pushNamed(context, '/addEvent');
        },
        child: const Icon(Icons.note_add_rounded), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 81, 56, 194),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
            backgroundColor: Color.fromARGB(255, 47, 39, 200),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Location',
            backgroundColor: Color.fromARGB(255, 69, 35, 204),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 68, 43, 229),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 15, 9, 65),
        onTap: _onItemTapped,
      ),
    );
  }
}

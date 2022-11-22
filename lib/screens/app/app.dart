import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_app/screens/app/friends_page.dart';
import 'package:music_app/screens/app/home_page.dart';
import 'package:music_app/screens/app/library_page.dart';

class App extends StatefulWidget {
  const App({super.key}); 

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  void _navigateBottomBar(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    }

  late List<Widget> _pages = [];
  @override
  void initState() {
    _pages = [
      HomePage(user: user, signOut: signOut),
      LibraryPage(),
      FriendsPage()
  ];
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: GNav(
              onTabChange: (index) {
                _navigateBottomBar(index);
              },
              selectedIndex: _selectedIndex,
              tabActiveBorder: Border.all(color: Colors.black, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              gap: 5,
              tabs: const [
                GButton(
                  icon: Icons.home, 
                  text: "Home",
                ),
                GButton(
                  icon: Icons.library_music_outlined, 
                  text: "Library",
                  ),
                GButton(
                  icon: Icons.people_alt, 
                text: "Friends",
                )
              ]
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex]
    );
  }
}
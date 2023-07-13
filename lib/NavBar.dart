import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'App/Grille.dart';
import 'App/ajouterImage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  static List<Widget> pages = [
    AjouterImage(),
    GridPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: GNav(
            onTabChange: (value){
              setState(() {
                _currentIndex = value;
              });
            },
            tabBorderRadius: 10,
            gap: 8,
            color: Colors.black,
            activeColor: Colors.white,
            iconSize: 25,
            tabBackgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            tabMargin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            tabs: [
              GButton(
                icon: Icons.image,
              ),
              GButton(
                icon: Icons.add_a_photo,
                text: 'Ajouter une image',
              ),

            ]),
      ),
    );
  }
}
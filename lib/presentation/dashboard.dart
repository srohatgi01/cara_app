import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/presentation/dashboard/cart.dart';
import 'package:cara_app/presentation/dashboard/homepage.dart';
import 'package:cara_app/presentation/dashboard/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //Selected Index of the app. Default is 0 when we will open the app
  int _selectedIndex = 0;

  // List of all the nav items
  static const List<Widget> _widgetOptions = <Widget>[HomePageScreen(), CartPageScreen(), ProfilePageScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(backgroundColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              tabBackgroundGradient: LinearGradient(colors: [
                Theme.of(context).primaryColor.withOpacity(.1),
                Theme.of(context).primaryColor.withOpacity(.1)
              ]),
              textStyle: TextStyle(fontFamily: 'NexaBold', color: Theme.of(context).primaryColor),
              haptic: false,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Theme.of(context).primaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/data/provider/auth/auth.dart';
import 'package:cara_app/presentation/google_auth_screen.dart';
import 'package:flutter/cupertino.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    Screen1(),
    Screen2(),
    Screen3()
  ];

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
                  text: 'Orders',
                ),
                GButton(
                  icon: LineIcons.personEnteringBooth,
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

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var isSignedIn;

  prefsFunction() async {
    super.initState();
    var prefs = await Prefs.init();

    isSignedIn = await prefs.isSignedIn();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    prefsFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: AppBar(
        backgroundColor: Color(backgroundColor),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cara',
          style: TextStyle(
              fontFamily: 'Signatra',
              fontSize: 45,
              color: Theme.of(context).primaryColor),
        ),
      ),
      body: isSignedIn == true
          ? Center(
              child: ElevatedButton(
                child: Text('Logout'),
                onPressed: () async {
                  await Auth().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoogleAuthScreen()));
                },
              ),
            )
          : Center(
              child: ElevatedButton(
                child: Text('Proceed to Sign In'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoogleAuthScreen()));
                },
              ),
            ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen2'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen3'),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:split_it/constants.dart';
import 'package:split_it/database/database.dart';
import 'package:split_it/login/loginPage.dart';
import 'package:split_it/view/contacts_page.dart';
import 'package:split_it/view/home_page.dart';

class Dashboard extends StatefulWidget {
  final String uid;

  Dashboard({Key key, this.uid}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(uid: uid);
}

class _DashboardState extends State<Dashboard> {
  final String uid;

  _DashboardState({@required this.uid});

  int tabIndex = 0;
  List<Widget> tabs;
  double screenHeight;
  double screenWidth;

  @override
  void initState() {
    super.initState();
    tabs = [
      HomePage(),
      ContactsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts,
            ),
            activeIcon: Icon(
              Icons.contacts,
              color: Colors.blue,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money,
            ),
            activeIcon: Icon(
              Icons.money,
              color: Colors.blue,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          print(index);
          setState(() {
            tabIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  child: Text('Sign Out'),
                ),
              ),
              IndexedStack(
                index: tabIndex,
                children: tabs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

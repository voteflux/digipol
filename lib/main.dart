import 'package:flutter/material.dart';
import 'package:voting_app/ui/screens/all_issues.dart';
import 'package:voting_app/ui/screens/settings.dart';
import 'package:voting_app/core/route_generator.dart';
import 'package:voting_app/ui/screens/all_bills.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    var child;

    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: child,
        home: new Scaffold(
          backgroundColor: appColors.background,
          //current page
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _currentIndex, 
              children: <Widget>[
                AllBillsPage(),
                AllIssuesPage(),
                ProfilePage(),
                SettingsPage()
            ]),
          ),
          // the nav bar at the bottom --> [bills - issues - Settings]
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                title: Text('Bills'),
                backgroundColor: appColors.background,              
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_late),
                title: Text('Issues'),
                backgroundColor: appColors.background,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile'),
                backgroundColor: appColors.background,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                backgroundColor: appColors.background,
              ),
            ],
            unselectedItemColor: appColors.text,
            selectedItemColor: appColors.mainTheme,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ));
  }
}

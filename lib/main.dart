import 'package:flutter/material.dart';
import 'package:voting_app/all_issues.dart';
import 'package:voting_app/profile.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/all_bills.dart';
import 'package:voting_app/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var child;
    var page;

    // for setting the page and the RouteGenerator
    switch (index) {
      // bills
      case 0:
        child = RouteGenerator.generateBillRoute;
        page = AllBillsPage();
        break;
        // issues
      case 1:
        page = AllIssuesPage();
        child = RouteGenerator.generateIssueRoute;
        break;
        // profile
      case 2:
        page = ProfilePage();
        child = RouteGenerator.generateSettingsRoute;
        break;
    }

    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: child,
        home: new Scaffold(
          backgroundColor: appColors.background,
          appBar: new AppBar(
            // Edit name and needs a good icon
            backgroundColor: appColors.mainTheme,
            title: new Text('DigiPol'),
          ),
          //current page
          body: page,
          // the nav bar at the bottom --> [bills - issues - profile]
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: appColors.mainTheme,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                title: Text('Bills'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_late),
                title: Text('Issues'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
            ],
            unselectedItemColor: appColors.text,
            currentIndex: index,
            onTap: (int index) {
              setState(() {
                this.index = index;
              });
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:voting_app/all_issues.dart';
import 'package:voting_app/bill.dart';
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

    switch (index) {
      case 0:
        print("Case 0");
        child = RouteGenerator.generateBillRoute;
        page = AllBillsPage();
        break;
      case 1:
        print("Case 1");
        page = AllIssuesPage();
        child = RouteGenerator.generateIssueRoute;
        break;
      case 2:
        print("Case 2");
        page = ProfilePage();
        child = RouteGenerator.generateSettingsRoute;
        break;
      case 3:
        print("Case 3");
        page = BillPage(data: {});
        child = RouteGenerator.generateBillRoute;
        break;
    }

    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: child,
        home: new Scaffold(
          backgroundColor: appColors.background,
          appBar: new AppBar(
            backgroundColor: appColors.mainTheme,
            title: new Text('DigiPol'),
          ),
          body: page,
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
            selectedItemColor: Colors.amber[900],
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

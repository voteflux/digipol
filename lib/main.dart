import 'package:flutter/material.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/ui/screens/all_issues_view.dart';
import 'package:voting_app/ui/screens/settings.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/route_generator.dart';
import 'package:voting_app/ui/screens/all_bills_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/screens/login.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(darkMode);
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (BuildContext context) =>
          locator<AuthenticationService>().userController.stream,
      child: MaterialApp(
        initialRoute: '/profile',
        home: MainScreen(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: RouteGenerator.generateSettingsRoute,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: appColors.background,
      //current page
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _currentIndex, children: <Widget>[
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
    );
  }
}

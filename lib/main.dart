import 'package:flutter/material.dart';
import 'package:voting_app/core/providers/auth/user_auth.dart';
import 'package:voting_app/ui/screens/all_issues.dart';
import 'package:voting_app/ui/screens/settings.dart';
import 'package:voting_app/ui/screens/all_bills.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/screens/login.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var child;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(darkMode);
    return MaterialApp(
        initialRoute: '/', 
        onGenerateRoute: child, 
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return ProfilePage();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return MainScreen();
            case Status.Authenticated:
              return MainScreen();
          }
        },
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

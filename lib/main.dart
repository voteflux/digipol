import 'package:flutter/material.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/viewmodels/settings_model.dart';
import 'package:voting_app/ui/appTheme.dart';
import 'package:voting_app/ui/views/all_issues_view.dart';
import 'package:voting_app/ui/views/settings.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/route_generator.dart';
import 'package:voting_app/ui/views/all_bills_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/login.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/locator.dart';
import 'package:instabug_flutter/Instabug.dart';


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
  initState() {
    super.initState();
    Instabug.start('dfdea6cecd71ae7d94d60d24dc881ff3', [InvocationEvent.shake]);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(darkMode);
    return MultiProvider(providers: [
      StreamProvider<User>(
        initialData: User.initial(),
        create: (BuildContext context) =>
            locator<AuthenticationService>().userController.stream,
      ),
      ListenableProvider<SettingsModel>(create: (context) => SettingsModel())
    ], child: MyMaterialApp());
  }
}

class MyMaterialApp extends StatefulWidget {
  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  String user;

  @override
  Widget build(BuildContext context) {
    Future setUser() async {
      var authservice = AuthenticationService();

      var isUser = await authservice.getUser();

      setState(() {
        user = isUser;
      });
    }

    @override
    void initState() {
      super.initState();
      setUser();
    }

    return Consumer<SettingsModel>(builder: (context, model, child) {
      return MaterialApp(
          initialRoute: user != null ? '/profile' : '/',
          home: MainScreen(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          onGenerateRoute: RouteGenerator.generateSettingsRoute,
          themeMode: model.isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });
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
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.primaryVariant,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Bills'),
              backgroundColor: Theme.of(context).backgroundColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_late),
              title: Text('Issues'),
              backgroundColor: Theme.of(context).backgroundColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
              backgroundColor: Theme.of(context).backgroundColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              backgroundColor: Theme.of(context).backgroundColor),
        ],
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

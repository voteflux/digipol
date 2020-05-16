import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/viewmodels/theme_model.dart';
import 'package:voting_app/ui/appTheme.dart';
import 'package:voting_app/ui/views/all_issues_view.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/views/login_view.dart';
import 'package:voting_app/ui/views/onboarding_view.dart';
import 'package:voting_app/ui/views/settings_view.dart';
import 'package:voting_app/core/route_generator.dart';
import 'package:voting_app/ui/views/all_bills_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:voting_app/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

//import 'package:instabug_flutter/Instabug.dart';
Api _api = locator<Api>();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<BlockChainData>(BlockChainDataAdapter());
  Hive.registerAdapter<Bill>(BillAdapter());
  Hive.registerAdapter<Issue>(IssueAdapter());
  await Hive.openBox<BlockChainData>("block_chain_data");
  await Hive.openBox<Bill>("bills");
  await Hive.openBox<Issue>("issues");

  setupLocator();
  await _api.syncData();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String user;
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<String> setUser() async {
    var isUser = await _authenticationService.getUser();
    user = isUser;
    print(user);
    return user;
  }

  @override
  initState() {
    super.initState();
    print("InstaBug here");
    setUser();
//    Instabug.start('dfdea6cecd71ae7d94d60d24dc881ff3', [InvocationEvent.shake]);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(darkMode);
    return BaseView<ThemeModel>(
        //onModelReady: (model) => model.setUser(),
        builder: (context, model, child) {
          return MaterialApp(
              onGenerateRoute: RouteGenerator.generateSettingsRoute,
              initialRoute: user == null ? '/profile' : '/' ,
              home: MainScreen(),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
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
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _currentIndex, children: <Widget>[
          AllBillsPage(),
          AllIssuesPage(),
          SettingsPage()
        ]),
      ),
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

import 'package:flutter/material.dart' hide Router;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/core/viewmodels/theme_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/appTheme.dart';
import 'package:voting_app/ui/views/all_bills_view.dart';
import 'package:voting_app/ui/views/all_issues_view.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/views/login/signin.dart';
import 'package:voting_app/ui/views/login_view.dart';
import 'package:voting_app/ui/views/settings_view.dart';
import 'package:voting_app/ui/views/user/profile_view.dart';

import 'core/consts.dart';

//import 'package:instabug_flutter/Instabug.dart';

void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<BlockChainData>(BlockChainDataAdapter());
  Hive.registerAdapter<Bill>(BillAdapter());
  Hive.registerAdapter<Issue>(IssueAdapter());
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<BillVote>(BillVoteAdapter());
  await Hive.openBox<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
  await Hive.openBox<Bill>(HIVE_BILLS);
  await Hive.openBox<Issue>(HIVE_ISSUES);
  await Hive.openBox<BillVote>(HIVE_BILL_VOTE_BOX);
  await Hive.openBox<bool>(HIVE_USER_PREFS_BOOLS);
  await Hive.openBox<String>(HIVE_USER_PREFS_STR);
  await Hive.openBox<List>(HIVE_USER_PREFS_LIST);
}

void main() async {
  await initHive();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ThemeModel>(
        builder: (context, model, child) => MaterialApp(
              onGenerateRoute: Router().onGenerateRoute,
              initialRoute: Routes.startupView,
              title: "DigiPol (TITLE)",
              navigatorKey: locator<NavigationService>().navigatorKey,
              // home: StartupView(), // MainScreen()
              // theme: AppTheme.lightTheme,
              // darkTheme: AppTheme.darkTheme,
              // themeMode: model.isDarkMode ? ThemeMode.dark : ThemeMode.light),
              builder: (context, extendedNav) =>
                  Theme(data: AppTheme.darkTheme, child: extendedNav),
            ));
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //FlutterStatusbarcolor.setStatusBarWhiteForeground(darkMode);
//     return BaseView<ThemeModel>(
//         onModelReady: (model) => model.setTheme(),
//         builder: (context, model, child) {
//           return MaterialApp(
//               builder: ExtendedNavigator.builder<Router>(
//             router: Router(),
//             initialRoute: Routes.startupView,
//
//             // home: StartupView(), // MainScreen()
//             // theme: AppTheme.lightTheme,
//             // darkTheme: AppTheme.darkTheme,
//             // themeMode: model.isDarkMode ? ThemeMode.dark : ThemeMode.light),
//             builder: (context, extendedNav) => Theme(
//               data: AppTheme.darkTheme,
//               child: extendedNav,
//             ),
//           ));
//         });
//   }
// }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: TabBar(
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                tabs: <Tab>[
                  Tab(icon: Icon(Icons.assignment)),
                  Tab(icon: Icon(Icons.assignment_late)),
                  Tab(icon: Icon(Icons.account_circle_rounded)),
                  Tab(icon: Icon(Icons.settings)),
                ]),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AllBillsPage(),
            AllIssuesPage(),
            ProfileHubPage(),
            SettingsPage()
          ],
        ),
      ),
    );
  }
}

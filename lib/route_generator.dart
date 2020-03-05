import 'package:flutter/material.dart';
import 'package:voting_app/all_bills.dart';
import 'package:voting_app/bill.dart';
import 'package:voting_app/all_issues.dart';
import 'package:voting_app/issue.dart';

class RouteGenerator {
  static Route<dynamic> generateBillRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AllBillsPage());

      case '/bill':
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => BillPage(
              data: args,
            ),
          );
        }

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();

    }

  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
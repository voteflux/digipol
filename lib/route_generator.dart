import 'package:flutter/material.dart';
import 'package:voting_app/all_bills.dart';
import 'package:voting_app/bill.dart';
import 'package:voting_app/all_issues.dart';
import 'package:voting_app/issue.dart';
import 'package:voting_app/main.dart';
import 'package:voting_app/profile.dart';
import 'package:voting_app/pdf_viewer.dart';

// there are three separate routing's. One for each for each;
// bills, issues and profile
// to switch between the above, use the bottomNavBar
// located in main.py

class RouteGenerator {
  /// for bills
  static Route<dynamic> generateBillRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());

      case '/item':
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => BillPage(
              data: args,
            ),
          );
        }
        return _errorRoute();

      case '/pdf':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => PdfPage(
                    pdfUrl: args,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  /// for issues
  static Route<dynamic> generateIssueRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());

      case '/item':
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => IssuePage(
              data: args,
            ),
          );
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  /// for profile
  static Route<dynamic> generateSettingsRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      default:
        return _errorRoute();
    }
  }

  /// for routing errors
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

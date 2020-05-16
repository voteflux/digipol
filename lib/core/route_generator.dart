import 'package:flutter/material.dart';
import 'package:voting_app/main.dart';
import 'package:voting_app/ui/views/login_view.dart';
import 'package:voting_app/ui/views/bills/pdf_viewer.dart';
import 'package:voting_app/ui/views/onboarding_view.dart';

// there are three separate routing's. One for each for each;
// bills, issues and Settings
// to switch between the above, use the bottomNavBar
// located in main.py

class RouteGenerator {
  /// for bills
  static Route<dynamic> generateBillRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());

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

      default:
        return _errorRoute();
    }
  }

  /// for Settings
  static Route<dynamic> generateSettingsRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnBoardingView());        

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

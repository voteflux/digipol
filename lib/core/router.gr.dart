// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../ui/views/login/signin.dart';
import '../ui/views/login_view.dart';
import '../ui/views/onboarding_view.dart';
import '../ui/views/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String signin = '/Signin';
  static const String mainScreen = '/main-screen';
  static const String profilePage = '/profile-page';
  static const String onBoardingView = '/on-boarding-view';
  static const String myApp = '/my-app';
  static const all = <String>{
    startupView,
    signin,
    mainScreen,
    profilePage,
    onBoardingView,
    myApp,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.signin, page: Signin),
    RouteDef(Routes.mainScreen, page: MainScreen),
    RouteDef(Routes.profilePage, page: ProfilePage),
    RouteDef(Routes.onBoardingView, page: OnBoardingView),
    RouteDef(Routes.myApp, page: MyApp),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<StartupView>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    Signin: (data) {
      return MaterialPageRoute<Signin>(
        builder: (context) => Signin(),
        settings: data,
      );
    },
    MainScreen: (data) {
      return MaterialPageRoute<MainScreen>(
        builder: (context) => MainScreen(),
        settings: data,
      );
    },
    ProfilePage: (data) {
      return MaterialPageRoute<ProfilePage>(
        builder: (context) => ProfilePage(),
        settings: data,
      );
    },
    OnBoardingView: (data) {
      return MaterialPageRoute<OnBoardingView>(
        builder: (context) => OnBoardingView(),
        settings: data,
      );
    },
    MyApp: (data) {
      return MaterialPageRoute<MyApp>(
        builder: (context) => MyApp(),
        settings: data,
      );
    },
  };
}

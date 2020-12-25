import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/services/auth_service.dart';

import '../../locator.dart';

class StartupView extends HookWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    return ViewModelBuilder<StartupViewModel>.reactive(
      onModelReady: (model) => model.runStartupLogic(),
      builder: (context, model, child) => Scaffold(
        body: Center(
            child: Lottie.asset('assets/lottie/digipol-logo.json',
                controller: animationController, onLoaded: (composition) {
          animationController.addStatusListener((status) async {
            if (status == AnimationStatus.completed) {
              await model.indicateAnimationComplete();
            }
          });
          animationController
            ..duration = composition.duration
            ..forward();
        })),
      ),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}

class StartupViewModel extends ChangeNotifier {
  final log = Logger();
  bool _animationComplete = false;
  String _destinationRoute = Routes.profilePage;
  dynamic _destinationArguments;
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Api _api = locator<Api>();

  Future indicateAnimationComplete() async {
    _animationComplete = true;
    await _replaceWith();
  }

  Future navigateHome() async {
    // TODO: Should I refactor this too? - Meena
    await _navigationService.navigateTo(Routes.mainScreen);
  }

  Future _replaceWith({String route, dynamic arguments}) async {
    var hasDestRoute = _destinationRoute != null;
    var hasDestArgs = _destinationArguments != null;

    _destinationRoute = !hasDestRoute ? route : _destinationRoute;
    _destinationArguments = !hasDestArgs ? arguments : _destinationArguments;

    if (_animationComplete && _destinationRoute != null) {
      await _navigationService.replaceWith(
        _destinationRoute,
        arguments: _destinationArguments,
      );
    }
  }

  Future runStartupLogic() async {
    // sync data on load
    await _api.syncData();
    var user = await _authenticationService.getUser();
  }
}

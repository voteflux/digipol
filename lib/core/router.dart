import 'package:auto_route/auto_route_annotations.dart';
import 'package:voting_app/main.dart';
import 'package:voting_app/ui/views/login_view.dart';
import 'package:voting_app/ui/views/onboarding_view.dart';
import 'package:voting_app/ui/views/startup_view.dart';
import 'package:voting_app/ui/views/login/signin.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute<StartupView>(page: StartupView, initial: true),
  MaterialRoute<Signin>(page: Signin),
  MaterialRoute<MainScreen>(page: MainScreen),
  MaterialRoute<ProfilePage>(page: ProfilePage),
  MaterialRoute<OnBoardingView>(page: OnBoardingView),
  MaterialRoute<MyApp>(page: MyApp),
])
class $Router {
  // StartupView startupRoute;
  // MainScreen mainScreenRoute;
  // ProfilePage profileRoute;
  // OnBoardingView onboardingRoute;
  // MyApp root;
}

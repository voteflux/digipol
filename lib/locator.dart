import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// import 'package:dartz/dartz.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:voting_app/core/services/auth_service.dart';
// import 'package:voting_app/core/viewmodels/all_issues_model.dart';
// import 'package:voting_app/core/viewmodels/bill_model.dart';
// import 'package:voting_app/core/viewmodels/bill_vote_model.dart';
// import 'package:voting_app/core/viewmodels/issue_model.dart';
// import 'package:voting_app/core/viewmodels/settings_model.dart';
// import 'package:voting_app/core/viewmodels/theme_model.dart';
// import 'package:voting_app/core/viewmodels/user_model.dart';
//
// import 'core/services/api.dart';
// import 'core/services/voting_service.dart';
// import 'core/services/wallet.dart';
// import 'core/viewmodels/all_bills_model.dart';
import 'locator.iconfig.dart';

final GetIt locator = GetIt.instance;

// void setupLocator() {
//   locator.registerLazySingleton(() => NavigationService());
//   locator.registerLazySingleton(() => Api());
//   locator.registerLazySingleton(() => AuthenticationService());
//   locator.registerLazySingleton(
//       () => VotingService(walletService: WalletService(None())));
//   locator.registerFactory(() => BillsModel());
//   locator.registerFactory(() => IssuesModel());
//   locator.registerFactory(() => UserModel());
//   locator.registerFactory(() => ThemeModel());
//   locator.registerFactory(() => BillModel());
//   locator.registerFactory(() => BillVoteModel());
//   locator.registerFactory(() => SettingsModel());
//   locator.registerFactory(() => IssueModel());
// }

@injectableInit
void setupLocator() => $initGetIt(locator);

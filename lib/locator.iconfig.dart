// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/viewmodels/bill_vote_model.dart';
import 'package:voting_app/core/viewmodels/all_bills_model.dart';
import 'package:voting_app/core/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:voting_app/core/viewmodels/issue_model.dart';
import 'package:voting_app/core/viewmodels/all_issues_model.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/viewmodels/settings_model.dart';
import 'package:voting_app/core/viewmodels/theme_model.dart';
import 'package:voting_app/core/services/user_api.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/services/voting_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<Api>(() => Api());
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerFactory<BaseModel>(() => BaseModel());
  g.registerFactory<BillModel>(() => BillModel(
        g<Bill>(),
        g<BillChainData>(),
        g<BillVoteResult>(),
        g<String>(),
      ));
  g.registerFactory<BillVoteModel>(() => BillVoteModel());
  g.registerFactory<BillsModel>(() => BillsModel.mkBillsModel());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerFactory<IssueModel>(() => IssueModel());
  g.registerFactory<IssuesModel>(
      () => IssuesModel(g<List<BlockChainData>>(), g<List<BlockChainData>>()));
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerFactory<SettingsModel>(() => SettingsModel());
  g.registerFactory<ThemeModel>(() => ThemeModel());
  g.registerLazySingleton<UserApi>(() => UserApi());
  g.registerFactory<UserModel>(() => UserModel());
  g.registerLazySingleton<WalletService>(() => WalletService());
  g.registerLazySingleton<VotingService>(
      () => VotingService(walletService: g<WalletService>()));
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}

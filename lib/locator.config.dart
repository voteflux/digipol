// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/services/api.dart';
import 'core/services/auth_service.dart';
import 'core/viewmodels/base_model.dart';
import 'core/models/bill.dart';
import 'core/models/bill_chain_data.dart';
import 'core/viewmodels/bill_model.dart';
import 'core/viewmodels/bill_vote_model.dart';
import 'core/models/bill_vote_result.dart';
import 'core/viewmodels/all_bills_model.dart';
import 'core/viewmodels/issue_model.dart';
import 'core/viewmodels/all_issues_model.dart';
import 'core/viewmodels/settings_model.dart';
import 'core/viewmodels/theme_model.dart';
import 'core/services/third_party_services_module.dart';
import 'core/services/user_api.dart';
import 'core/viewmodels/user_model.dart';
import 'core/services/voting_service.dart';
import 'core/services/wallet.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<Api>(() => Api());
  gh.lazySingleton<AuthenticationService>(() => AuthenticationService());
  gh.factory<BaseModel>(() => BaseModel());
  gh.factory<BillModel>(() => BillModel(
        get<Bill>(),
        get<BillChainData>(),
        get<BillVoteResult>(),
        get<String>(),
      ));
  gh.factory<BillVoteModel>(() => BillVoteModel());
  gh.factory<BillsModel>(() => BillsModel.mkBillsModel());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.factory<IssueModel>(() => IssueModel());
  gh.factory<IssuesModel>(() => IssuesModel());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.factory<SettingsModel>(() => SettingsModel());
  gh.factory<ThemeModel>(() => ThemeModel());
  gh.lazySingleton<UserApi>(() => UserApi());
  gh.factory<UserModel>(() => UserModel());
  gh.lazySingleton<WalletService>(() => WalletService());
  gh.lazySingleton<VotingService>(
      () => VotingService(walletService: get<WalletService>()));
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}

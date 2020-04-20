import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class IssuesModel extends BaseModel {
  Api _api = locator<Api>();

  List<Issue> issues;

  Future getIssues() async {
    setState(ViewState.Busy);
    issues = await _api.getIssues();
    print('all_issues');
    setState(ViewState.Idle);
  }
}
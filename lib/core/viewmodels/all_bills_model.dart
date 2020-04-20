import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class BillsModel extends BaseModel {
  Api _api = locator<Api>();

  List<Bill> bills;

  Future getBills() async {
    setState(ViewState.Busy);
    bills = await _api.getBills();
    print('all_bills');
    setState(ViewState.Idle);
  }
}
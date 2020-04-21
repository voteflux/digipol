import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class BillModel extends BaseModel {
  Api _api = locator<Api>();

  Bill bill;

  Future getBill(String billID) async {
    setState(ViewState.Busy);
    bill = await _api.getBill();
    print('all_bills');
    setState(ViewState.Idle);
  }
}
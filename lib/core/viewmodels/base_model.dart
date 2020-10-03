import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:voting_app/core/enums/viewstate.dart';

@injectable
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

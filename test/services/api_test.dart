import 'package:flutter/widgets.dart';
import 'package:test/test.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/main.dart';

Api _api = locator<Api>();

void main() async {
  await initHive();
  setupLocator();
  // sync data on load
  WidgetsFlutterBinding.ensureInitialized();

  group('api', () {
    test('test api data syncing', () async {
      await _api.syncData();
    });
  });
}

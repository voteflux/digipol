import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:test/test.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/main.dart';

Api _api = locator<Api>();

// mock filesystem stuff in tests
const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
// need to assign it or something apparently.
var meh = channel.setMockMethodCallHandler((MethodCall methodCall) async {
  return ".";
});

void main() async {
  // mock filesystem stuff in tests
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  // need to assign it or something apparently.
  var meh = channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  WidgetsFlutterBinding.ensureInitialized();
  // if we use TestWidgetsFlutterBinding.ensureInitialized we need to provide a
  // custom HTTP thing b/c no network requests will actually happen. That's
  // a good thing to do in the long term, but not a priority for today.
  //TestWidgetsFlutterBinding.ensureInitialized();
  await initHive();
  setupLocator();
  // sync data on load

  group('api', () {
    test('test api data syncing', () async {
      await _api.syncData();
    });
  });
}

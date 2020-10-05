import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/main.dart';

import '../setup/test_helpers.dart';

final Logger log = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  registerServices();
  // sync data on load

  // this isn't using ApiMock -- replace with that when appropriate or replace with whatever we replace Api with.
  Api _api = Api();

  group('api', () {
    test('test api data syncing', () async {
      await _api.syncData();
    });
  });
}

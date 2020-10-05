import 'package:flutter_test/flutter_test.dart';
import 'package:voting_app/ui/views/startup_view.dart';

import '../setup/test_helpers.dart';

void main() {
  group('StartupViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());

    group('initialise -', () {
      test('StartupViewModel initialisation', () async {
        var model = StartupViewModel();
        // keep the `var user` while we're still using a string for a user.
        var user = await model.initialize();
      });
    });
  });
}

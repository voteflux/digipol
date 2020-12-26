
import 'package:flutter_test/flutter_test.dart';
import 'package:voting_app/core/funcs/convert_topic.dart';



void main() async {
  test('Test junk input', () {
    String result = topicConverter("sfasdfasfda");
    assert(result == "Australia");
  }
  );
}

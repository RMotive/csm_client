import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:csm_foundation_services/src/common/tools/csm_deserealizer.dart';
import 'package:test/test.dart';

void main() {
  late final JObject mock;

  setUp(
    () {
      mock = <String, dynamic>{
        'first': 1,
      };
    },
  );

  test(
    'Deserealize',
    () async {
      MockClass fact = deserealize(mock);

      expect(fact.first, mock['first']);
    },
  );
}

final class MockClass {
  final int first;

  const MockClass(this.first);

  factory MockClass.des(JObject json) {
    return MockClass(json['first']);
  }
}

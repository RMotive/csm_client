@TestOn('browser')
library;

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';

import '../../../shared/mocks/mock_class.dart';
import '../../../shared/mocks/mock_class_generic.dart';

void main() {
  late JObject mock;

  setUp(
    () {
      mock = <String, dynamic>{
        'first': 1,
      };
    },
  );

  test(
    '(Native) Deserealize',
    () async {
      MockClass fact = MockClass.des(mock);

      expect(fact.first, mock['first']);
    },
  );

  test(
    '(Native) Deserealize with generics',
    () async {
      MockClassGeneric<MockClass> fact = MockClassGeneric<MockClass>.des(mock, MockClass.des);

      expect(fact.first, mock['first']);
    },
  );
}

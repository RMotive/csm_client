@TestOn('vm')
library;

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';

import '../../shared/mocks/mock_class_generic.dart';

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
      MockClass fact = deserealize(mock);

      expect(fact.first, mock['first']);
    },
  );

  test(
    '(Native) Deserealize with generics',
    () async {
      MockClassGenericDecode<MockClass> decoder = MockClassGenericDecode<MockClass>(MockClassDecode());

      MockClassGeneric<MockClass> fact = deserealize<MockClassGeneric<MockClass>>(
        mock,
        decode: decoder,
      );

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

final class MockClassDecode implements CSMDecodeInterface<MockClass> {
  @override
  MockClass decode(JObject json) {
    return MockClass.des(json);
  }
}

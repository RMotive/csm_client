import 'package:csm_client/src/common/typedefs.dart';

final class MockClass {
  final int first;

  const MockClass(this.first);

  factory MockClass.des(JObject json) {
    return MockClass(json['first']);
  }
}

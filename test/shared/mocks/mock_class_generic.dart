import 'package:csm_client/src/common/typedefs.dart';

final class MockClassGeneric<T> {
  final int first;

  const MockClassGeneric(this.first);

  factory MockClassGeneric.des(JObject json, T Function(JObject json) aDes) {
    return MockClassGeneric<T>(json['first']);
  }
}

import 'package:csm_foundation_services/src/common/typedefs.dart';
import 'package:csm_foundation_services/src/interfaces/csm_decode_interface.dart';

final class MockClassGeneric<T> {
  final int first;

  const MockClassGeneric(this.first);

  factory MockClassGeneric.des(JObject json) {
    return MockClassGeneric<T>(json['first']);
  }
}

final class MockClassGenericDecode<T> implements CSMDecodeInterface<MockClassGeneric<T>> {
  final CSMDecodeInterface<T> genericDecoder;
  const MockClassGenericDecode(this.genericDecoder);

  @override
  decode(JObject json) {
    return MockClassGeneric<T>.des(json);
  }
}

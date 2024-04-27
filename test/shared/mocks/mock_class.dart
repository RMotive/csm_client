import 'package:csm_foundation_services/src/common/typedefs.dart';
import 'package:csm_foundation_services/src/interfaces/csm_decode_interface.dart';

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

import 'package:csm_client/src/common/common_module.dart';
import 'package:test/test.dart';

final class CustomModel {}

void main() {
  JObject mock = <String, dynamic>{};

  setUp(
    () {
      for (int i = 0; i < 3; i++) {
        mock['model'] = <dynamic>[null, null, null];
      }
    },
  );

  test(
    'getDefault (When trying to get a list of objects with null elements)',
    () async {
      final List<CustomModel> result = mock.getList<CustomModel>('model');

      assert(result.isEmpty);
    },
  );
}

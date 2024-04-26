import 'package:csm_foundation_services/csm_foundation_services.dart';

abstract interface class CSMDecodeInterface<T> {
  T decode(JObject json);
}

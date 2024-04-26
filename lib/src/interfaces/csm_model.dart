import 'package:csm_foundation_services/csm_foundation_services.dart';

abstract interface class CSMModel<TModel> {
  JObject encode();
  TModel decode(JObject json);
}

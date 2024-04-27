import 'package:csm_foundation_services/csm_foundation_services.dart';

T deserealize<T>(
  JObject json, {
  CSMDecodeInterface<T>? decode,
}) {
  const String excepScope = 'MirrorException';
  if (decode == null) {
    throw '$excepScope: On browser platforms is mandatory to provide decode implementation';
  }

  return decode.decode(json);
}


const bool native = false;
const bool browser = true;

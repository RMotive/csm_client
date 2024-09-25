import 'package:csm_client/csm_client.dart';

@Deprecated("No longer needed since decodes were moved to functions")
T deserealize<T>(
  JObject json, {
  T Function(JObject json)? decode,
}) {
  const String excepScope = 'MirrorException';
  if (decode == null) {
    throw '$excepScope: On browser platforms is mandatory to provide decode implementation';
  }

  return decode(json);
}


const bool nativeDeserealizer = false;
const bool browserDeserealizer = true;

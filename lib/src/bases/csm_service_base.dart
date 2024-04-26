import 'dart:convert';

import 'package:csm_foundation_services/src/common/common_module.dart';
import 'package:csm_foundation_services/src/csm_act_effect.dart';
import 'package:csm_foundation_services/src/interfaces/interfaces_module.dart';
import 'package:csm_foundation_services/src/models/models_module.dart';
import 'package:http/http.dart';

/// Base for [CSMService].
///
/// Defines base behavior for a [CSMService] implementation.
///
/// [CSMService] concept: is a set of operations where get data by protocol transactions,
/// like an endpoint. (i.e.) google.com/security <-- service; google.com/security/calculate <-- act, where the operation will be solved with data.
abstract class CSMServiceBase implements CSMServiceInterface {
  @override
  late final CSMUri endpoint;

  @override
  late final Client comm;

  /// Default headers to indicate a standard [JSON] transaction.
  static const CSMHeaders _kHeaders = <String, String>{
    "accept-type": 'application/json',
    "content-type": 'application/json',
  };

  /// Generates a new [CSMServiceBase] behavior handler.
  CSMServiceBase(
    CSMUri host,
    String servicePath, {
    Client? client,
  }) {
    endpoint = CSMUri.includeEndpoint(host, servicePath);
    comm = client ?? Client();
  }

  @override
  Future<CSMActEffect> post<S, E, M extends CSMEncodeInterface>(
    String act,
    M request, {
    CSMHeaders? headers,
  }) async {
    Uri uri = endpoint.resolve(endpoint: act);
    try {
      JObject jObject = request.encode();
      final Response response = await comm.post(
        uri,
        headers: headers ?? _kHeaders,
        body: jsonEncode(jObject),
      );
      final JObject parsedBody = jsonDecode(response.body);
      final int statusCode = response.statusCode;
      if (response.statusCode == 200) return CSMActEffect(success: parsedBody, status: 200);
      return CSMActEffect(error: parsedBody, status: statusCode);
    } catch (x, st) {
      return CSMActEffect(exception: x, trace: st);
    }
  }
}

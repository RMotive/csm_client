import 'package:csm_foundation_services/src/common/common_module.dart';
import 'package:csm_foundation_services/src/csm_act_effect.dart';
import 'package:csm_foundation_services/src/interfaces/csm_encode_interface.dart';
import 'package:csm_foundation_services/src/models/models_module.dart';
import 'package:http/http.dart';

/// Interface for [CSMService].
///
/// Defines require behavior for a [CSMService] implementation.
///
/// [CSMService] concept: is a set of operations where get data by protocol transactions,
/// like an endpoint. (i.e.) google.com/security <-- service; google.com/security/calculate <-- act, where the operation will be solved with data.
abstract interface class CSMServiceInterface {
  static const String authKey = 'CSMAuth'; 

  /// The current service network location.
  late final CSMUri endpoint;

  /// The current service network connection communicator provider.
  late final Client comm;

  /// Performs a [POST] method action via network connection to the specified [endpoint] properties calculated with the
  /// [act] given location inside the [endpoint] hosting.
  ///
  /// [act] - Path segment where the act is inside the service [endpoint] that hosts the set of [act]´s.
  ///
  /// [request] - The request structured object that stores all the required data by the [act].
  ///
  /// [headers] - Optional headers to be sent to the calculated [act] network location.
  Future<CSMActEffect> post<M extends CSMEncodeInterface>(
    String act,
    M request, {
    String? auth,
    CSMHeaders? headers,
  });

  /// Performs a [POST] method action via network connection to the specified [endpoint] properties calculated with the
  /// [act] given location inside the [endpoint] hosting.
  ///
  /// [act] - Path segment where the act is inside the service [endpoint] that hosts the set of [act]´s.
  ///
  /// [request] - The request list of structured objects that stores all the required data by the [act].
  ///
  /// [headers] - Optional headers to be sent to the calculated [act] network location.
  Future<CSMActEffect> postList<M extends CSMEncodeInterface>(
    String act,
    List<M> request, {
    String? auth,
    CSMHeaders? headers,
  });
}

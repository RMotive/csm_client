import 'package:csm_foundation_services/src/common/common_module.dart';

/// Interface for [CSMActEffect].
///
/// Defines require behavior for a [CSMActEffect] implementation.
///
/// [CSMActEffect] Concept: a service response.
abstract interface class CSMActEffectInterface {
  /// Resolves the current [CSMActEffect].
  ///
  /// [onSuccess] - When the [ActEffect] resulves successfuly.
  /// [onFailure] - When the [ActEffect] receives a failed [StatusCode].
  /// [onException] - When the [ActEffect] got interrupted by an exception.
  /// [log] - Wheter the exception should be logged.
  void resolve(Function(JObject success) onSuccess, Function(JObject failure, int statusCode) onFailure, Function(Object exception, StackTrace trace) onException);
}

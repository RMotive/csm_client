import 'package:csm_foundation_services/src/common/common_module.dart';
import 'package:csm_foundation_services/src/interfaces/interfaces_module.dart';

/// Base for [CSMActEffect].
///
/// Defines base behavior for a [CSMActEffect] implementation.
///
/// [CSMActEffect] Concept: a service response.
///
/// NOTE! Properties are set as optional, but the implementation should set them in their constructor,
/// if not, the implementation class won´t have access to [CSMActEffectBase] behavior.
abstract class CSMActEffectBase implements CSMActEffectInterface {
  /// Successed service object.
  final JObject? _success;

  /// Failed service object.
  final JObject? _error;

  /// Exception thrown during [ActEffect].
  final Object? _exception;

  /// Exception trace gathered during [_exception] caught.
  final StackTrace? _trace;

  /// [HTTP] transaction status code, this is a global netwroking standard.
  final int? _status;

  /// Generates a [CSMActEffectBase] behavior handler.
  const CSMActEffectBase({
    JObject? success,
    JObject? error,
    Object? exception,
    StackTrace? trace,
    int? status,
  })  : _success = success,
        _error = error,
        _exception = exception,
        _trace = trace,
        _status = status;

  @override
  void resolve(
    Function(JObject success) onSuccess,
    Function(JObject failure, int statusCode) onFailure,
    Function(Object exception, StackTrace trace) onException,
  ) {
    if (_success != null) {
      onSuccess(_success);
      return;
    }
    if (_error != null) {
      onFailure(_error, _status ?? 0);
      return;
    }

    Object excep = _exception ?? Exception("No success, no error, no exception");
    StackTrace trace = _trace ?? StackTrace.current;
    onException(excep, trace);
  }
}

import 'package:csm_foundation_services/src/bases/bases_module.dart';

/// Class for [CSMActEffect].
///
/// Defines final behavior for a [CSMActEffect] implementation.
///
/// [CSMActEffect] Concept: a service response.
final class CSMActEffect extends CSMActEffectBase {
  /// Generates a [CSMActEffect] object.
  const CSMActEffect({
    super.success,
    super.error,
    super.exception,
    super.trace,
    super.status,
  });
}

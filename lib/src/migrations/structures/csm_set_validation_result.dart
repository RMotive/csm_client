/// Structure that represent the information related to a [Set] property validation error.
final class CSMSetValidationResult {
  /// Name of the invaldiated property.
  final String property;

  /// User safe invalidation reason.
  final String reason;

  /// Internal knowledge about the applied rules.
  final String rules;

  /// Creates a new [CSMSetValidationResult] object instance that represent a [Set] property validation result.
  const CSMSetValidationResult(this.property, this.reason, this.rules);
}

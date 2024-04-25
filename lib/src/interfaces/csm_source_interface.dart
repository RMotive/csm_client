import 'package:csm_foundation_services/src/models/models_module.dart';

/// Interface for [CSMRepository].
///
/// Defines a require behavior for [CSMRepository] implementation.
///
/// [CSMRepository] concept: defines a network source of data that hosts services or another data providing abtraction.
abstract interface class CSMSourceInterface {
  /// The current runtime calculated host.
  final CSMUri host;

  /// Host when the runtime is on production.
  final CSMUri? production;

  /// Host when the runtime in on development.
  final CSMUri development;

  const CSMSourceInterface(this.host, this.production, this.development);
}

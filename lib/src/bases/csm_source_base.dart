import 'package:csm_foundation_services/src/interfaces/interfaces_module.dart';
import 'package:csm_foundation_services/src/models/models_module.dart';
import 'package:http/http.dart';

/// Base for [CSMRepository].
///
/// Defines a require behavior for [CSMRepository] implementation.
///
/// [CSMRepository] concept: defines a network source of data that hosts services or another data providing abtraction.
abstract class CSMSourceBase implements CSMSourceInterface {
  /// The current runtime calculated host.
  @override
  late final CSMUri host;

  /// Host when the runtime is on production.
  @override
  final CSMUri? production;

  /// Host when the runtime in on development.
  @override
  final CSMUri development;

  @override
  final Client? client;

  /// Generates a [CSMRepository] behavior handler.
  CSMSourceBase(
    bool debug,
    this.development, {
    this.production,
    this.client,
  }) {
    host = debug ? development : (production ?? development);
  }
}

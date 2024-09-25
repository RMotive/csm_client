import 'package:csm_client/csm_client.dart';

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

  final CSMHeaders? headers;

  /// Generates a [CSMRepository] behavior handler.
  CSMSourceBase(
    bool debug,
    this.development, {
    this.production,
    this.client,
    this.headers,
  }) {
    host = debug ? development : (production ?? development);
  }
}

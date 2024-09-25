import 'package:csm_client/src/common/common_module.dart';

/// Record class for [CSMUri].
///
/// Defines a structured object for a [CSMUri] implementation.
///
/// [CSMUri] concept: a set of data that describes a network [Uri] at its properties.
final class CSMUri {
  /// Defined protocol for the connection to stablish,
  final CSMProtocols protocol;

  /// Host domain to connect with.
  final String host;

  /// Path inside the [host] that points the endpoint.
  final String path;

  /// Communication port to connect with.
  final int? port;

  /// Parameters to send to the endpoint via query.
  final JObject? qryParams;

  /// Generates a new [CSMUri] record object.
  const CSMUri(
    this.host,
    this.path, {
    this.port,
    this.qryParams,
    this.protocol = CSMProtocols.https,
  });

  /// Generates a new [CSMUri] structured object.
  ///
  /// [source] - a parent [CSMUri] to calculate this new object creation properties.
  /// [endpoint] - the current endpoint to calculate based on [source] properties.
  factory CSMUri.includeEndpoint(CSMUri source, String endpoint) {
    return CSMUri(
      source.host,
      '${source.path}/$endpoint',
      port: source.port,
      qryParams: source.qryParams,
      protocol: source.protocol,
    );
  }

  Uri resolve({String? endpoint}) {
    String buildtEndpoint = path;
    if (endpoint != null) buildtEndpoint += '/$endpoint';

    return Uri(
      scheme: protocol.scheme,
      host: host,
      path: buildtEndpoint,
      port: port,
      queryParameters: qryParams,
    );
  }
}

/// Enum for [CSMProtocols].
///
/// Defines an enumerator for a [CSMProtocols] implementation.
///
/// [CSMProtocols] concept: describes a set of possibles protocols for network communication,
/// trying to connect to a server via one of this protocols.
enum CSMProtocols {
  https('https'),
  http('http'),
  curl('curl');

  /// Reflection of the current option to an accepted native [Scheme] transaction concept.
  final String scheme;

  /// Generates a new [CSMProtocols] option.
  const CSMProtocols(this.scheme);
}

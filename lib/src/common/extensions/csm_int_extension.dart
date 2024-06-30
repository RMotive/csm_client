/// Provides extension utilities by [CSM] to enhance native [int].
extension CSMIntExtension on int {
  /// Gets the equivalent of the current [int] in seconds from a [Duration] object.
  Duration get secs => Duration(seconds: this);

  /// Gets the equivalent of the current [int] in seconds from a [Duration] object.
  Duration get milisecs => Duration(milliseconds: this);
}

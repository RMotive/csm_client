import 'package:csm_client/csm_client.dart';

/// Defines a [Migration] internal product concept interface to define
/// base requirements for [Set] implementations and definitions.
///
/// [Migration]: concept related to everything from the databases sources.
abstract interface class CSMSetInterface implements CSMEncodeInterface {
  /// Set record pointer.
  late int id;

  /// Client level evaluation for this set record to check if can be written correctly by the service.
  ///
  /// If the result list came empty, means no validation results were thrown (meaning the evaluation is correct).
  List<CSMSetValidationResult> evaluate();
}

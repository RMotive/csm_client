import 'package:csm_foundation_services/src/common/common_module.dart';

/// Interface for [CSMActionInput].
///
/// Defines a require behavior for a [CSMActionInput] implementation.
///
/// [CSMActionInput] concept: is a data structured object sent to a [act] from a service,
/// usually used on [POST, UPDATE, PATCH] network methods.
abstract interface class CSMActInputInterface {
  /// Converts the current [CSMActionInput] structured object to an universal data structure standard to be handled by a network transaction.
  JObject toJson();
}

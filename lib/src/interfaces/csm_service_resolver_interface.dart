import 'package:csm_client/src/csm_act_effect.dart';

/// Interface for [CSMServiceResolver].
///
/// Defines require behavrior for a [CSMServiceResolver] impolementation.
///
/// [TSuccess] - Defines the generic reflected type of the [Success] object that will be created when the [ActEffect] is resolved successfuly.
///
/// [CSMServiceResolver] concept: custom resolvers for each service implemented, used to simplify the objects factory and the
/// resolution of services responses.
abstract interface class CSMServiceResolverInterface<TSuccess> {
  /// [act] network operation result from a [CSMService].
  final CSMActEffect result;

  const CSMServiceResolverInterface(this.result);
}

import 'package:csm_foundation_services/src/csm_act_effect.dart';
import 'package:csm_foundation_services/src/interfaces/interfaces_module.dart';

/// Base for [CSMServiceResolver].
///
/// Defines base behavrior for a [CSMServiceResolver] impolementation.
///
/// [TSuccess] - Defines the generic reflected type of the [Success] object that will be created when the [ActEffect] is resolved successfuly.
///
/// [CSMServiceResolver] concept: custom resolvers for each service implemented, used to simplify the objects factory and the
/// resolution of services responses.
abstract class CSMServiceResolverBase<TSuccess> implements CSMServiceResolverInterface<TSuccess> {
  /// [act] network operation result from a [CSMService].
  @override
  final CSMActEffect result;

  /// Generates a new [CSMServiceResolverBase] behavior handler.
  const CSMServiceResolverBase(this.result);
}

import 'dart:mirrors';

import 'package:csm_foundation_services/csm_foundation_services.dart';

/// Deserealizes the given generic class [T] based on its own [des] method, passing [json] object.
///
/// Can throw [MirrorException].
T deserealize<T>(
  JObject json, {
  CSMDecodeInterface<T>? decode,
}) {
  ClassMirror reflected = reflectClass(T);
  String factoryName = '${reflected.simpleName}.des';
  Symbol symbolReference = Symbol(factoryName);

  DeclarationMirror? method = reflected.declarations[symbolReference];
  if (method is! MethodMirror || !(method.isFactoryConstructor)) {
    throw 'MirrorException: Class $T must contain a factory method $factoryName(JObject json) where JObject = Map<String, dynamic>';
  }

  InstanceMirror intansce = reflected.newInstance(#des, <dynamic>[json]);
  return intansce.reflectee as T;
}

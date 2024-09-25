import 'dart:mirrors';

import 'package:csm_client/csm_client.dart';

/// Deserealizes the given generic class [T] based on its own [des] method, passing [json] object.
///
/// Can throw [MirrorException].
@Deprecated("No longer needed since decodes were moved to functions")
T deserealize<T>(
  JObject json, {
  T Function(JObject json)? decode,
}) {
  const String excepScope = 'MirrorException';

  ClassMirror reflected = reflectClass(T);
  if (!reflected.hasReflectedType && decode == null) {
    throw '$excepScope: Unsupported to deserealize generic classes, for them please provide [$T Function(JObject) json] decode implementation';
  }

  if (!reflected.hasReflectedType && decode != null) {
    return decode(json);
  }

  String className = reflected.simpleName.toString().split('"')[1];
  Symbol instanceFactory = Symbol('$className.des');

  DeclarationMirror? method = reflected.declarations[instanceFactory];
  if (method is! MethodMirror || !(method.isFactoryConstructor)) {
    throw ': Class $T must contain a factory method $className(JObject json) where JObject = Map<String, dynamic>';
  }

  InstanceMirror intansce = reflected.newInstance(#des, <dynamic>[json]);

  return intansce.reflectee as T;
}

const bool nativeDeserealizer = true;
const bool browserDeserealizer = false;

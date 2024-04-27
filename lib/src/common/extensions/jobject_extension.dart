import 'dart:ffi';

import 'package:csm_foundation_services/src/common/common_module.dart';

/// Provides utilities to handle jObjects such read and write.
extension JUtils on JObject {
  /// Binds an specified property into the gathered json.
  ///
  /// [json] The json object to scrap in.
  ///
  /// [fallbacks] The specified keys to search into the json.
  ///   It will be used in the order it is given, if the first key does't found any, then will be used the another one.
  ///
  /// [defaultValue] The specified default value to return if all the fallbacks resulted in a null value.
  ///
  /// [caseSensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  TExpectation _bindProperty<TExpectation>(List<String> fallbacks, TExpectation defaultValue, {bool caseSensitive = false}) {
    TExpectation? gatheredValue;
    for (String key in fallbacks) {
      for (JEntry element in entries) {
        final String currentElementKey = element.key;
        if (caseSensitive && (currentElementKey != key)) continue;
        if (!caseSensitive && (currentElementKey.toLowerCase() != key.toLowerCase())) continue;
        gatheredValue = (element.value as TExpectation);
        break;
      }
      if (gatheredValue != null) break;
    }
    return gatheredValue ?? defaultValue;
  }

  static JObject get empty => <String, dynamic>{};

  static const List<Type> _supported = <Type>[
    String,
    int,
    DateTime,
  ];


  DateTime _getDateTime(String key, bool sensitive) {
    String stringValue = _bindProperty(<String>[key], '', caseSensitive: sensitive);

    if (stringValue.isEmpty) {
      return DateTime(0);
    }

    return DateTime.parse(stringValue);
  }
  int _getInt(String key, bool sensitive) {
    String jValue = _bindProperty(<String>[], '', caseSensitive: sensitive);
    if (jValue.isEmpty) throw 'InvalidType: Invalid expected type $Int received an empty';

    int? value = int.tryParse(jValue);
    if (value == null) throw 'InvalidType: Unable to convert $jValue into expected $Int';
    return value;
  }

  T get<T>(String key, {bool sensitive = false}) {
    if (!_supported.contains(T)) {
      throw 'Unsupported: This method doesn\'t allow binding for $T';
    }

    if (T is DateTime) return _getDateTime(key, sensitive) as T;
    if (T is String) return _bindProperty(<String>[key], '', caseSensitive: sensitive) as T;
    if (T is int) return _getInt(key, sensitive) as T;

    throw 'CriticalException: Couldn\'t found $T convertion implementation and broke up validations';
  }

  T getDefault<T>(String key, T defaultValue) => _bindProperty(<String>[key], defaultValue);
  T getSensitive<T>(String key, T defaultValue) => _bindProperty(<String>[key], defaultValue, caseSensitive: true);
  T getFallback<T>(List<String> fallback, T defaultValue) => _bindProperty(fallback, defaultValue);
  T getFallbackSensitive<T>(List<String> fallback, T defaultValue) => _bindProperty(fallback, defaultValue, caseSensitive: true);
}

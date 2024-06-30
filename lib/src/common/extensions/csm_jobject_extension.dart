import 'package:csm_foundation_services/src/common/common_module.dart';

/// Provides [CSM] utilities to handle [JObject] concept enhancement.
extension CSMJObjectExtension on JObject {
  /// Stores the current supported [Type]'s to auto cast and run specific sanitization.
  static const List<Type> _supported = <Type>[
    String,
    int,
    DateTime,
    bool,
    Map<String, dynamic>,
    List<Map<String, dynamic>>,
  ];

  /// Binds an specific property value casting to the giuven [TExpectation], if the cast results in a null value will
  /// return given [defaultValue].
  ///
  /// [caseSensitive]: indicates if the [binder] should match the [fallbacks] casing with the [JObject] keys.
  TExpectation _bindProperty<TExpectation>(List<String> fallbacks, TExpectation defaultValue, {bool caseSensitive = false}) {
    TExpectation? gatheredValue;
    dynamic value = _bindValue(fallbacks, caseSensitive: caseSensitive);
    gatheredValue = (value as TExpectation?);

    return gatheredValue ?? defaultValue;
  }

  /// Binds an Specified property value into the current [JObject].
  ///
  /// [fallbacks] The specified keys to search into the json.
  /// It will be used in the order it is given, if the first key does't found any, then will be used the another one.
  ///
  /// [caseSensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  dynamic _bindValue(List<String> fallbacks, {bool caseSensitive = false}) {
    for (String key in fallbacks) {
      for (JEntry element in entries) {
        final String currentElementKey = element.key;
        if (caseSensitive && (currentElementKey != key)) continue;
        if (!caseSensitive && (currentElementKey.toLowerCase() != key.toLowerCase())) continue;
        return element.value;
      }
    }
  }

  /// Specified sanitization procedures for [DateTime] supported [Type].
  /// This is used by [get] implementations and is permorfed when the requested
  /// value is a [DateTime].
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [sensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  DateTime _getDateTime(String key, bool sensitive) {
    String stringValue = _bindProperty(<String>[key], '', caseSensitive: sensitive);

    if (stringValue.isEmpty) {
      return DateTime(0);
    }

    return DateTime.parse(stringValue);
  }

  /// Specified sanitization procedures for [int] supported [Type].
  /// This is used by [get] implementations and is permorfed when the requested
  /// value is a [int].
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [sensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  int _getInt(String key, bool sensitive) {
    int? value = _bindProperty(<String>[key], null, caseSensitive: sensitive);
    if (value == null) {
      throw 'InvalidType: Unable to convert ${value.runtimeType} into expected $int';
    }
    return value;
  }

  /// Specified sanitization procedures for [List] of [JObject] supported [Type].
  /// This is used by [get] implementations and is permorfed when the requested
  /// value is a [List] of [JObject].
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [sensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  List<JObject> _getListMapStringDynamic(String key, bool sensitive) {
    List<dynamic> bindedList = _bindProperty(<String>[key], <Map<String, dynamic>>[]);
    List<JObject> castList = bindedList.cast<JObject>();

    return castList;
  }

  /// Specifies a property value binding strict, this means if the requested [T] doesn't match the binded
  /// [Type] then'll throw an exception.
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [sensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  T get<T>(String key, {bool sensitive = false}) {
    if (!_supported.contains(T)) {
      throw 'Unsupported: This method doesn\'t allow binding for $T';
    }

    if (T == DateTime) return _getDateTime(key, sensitive) as T;
    if (T == String) return _bindProperty(<String>[key], '', caseSensitive: sensitive) as T;
    if (T == int) return _getInt(key, sensitive) as T;
    if (T == Map<String, dynamic>) return _bindProperty(<String>[key], <String, dynamic>{} as T, caseSensitive: sensitive);
    if (T == List<Map<String, dynamic>>) return _getListMapStringDynamic(key, sensitive) as T;
    if (T == bool) return _bindProperty(<String>[key], false as T, caseSensitive: sensitive);

    throw 'CriticalException: Couldn\'t found $T convertion implementation and broke up validations';
  }

  /// Specifies a property value binding strict for [List] of [T], if the direct cast fails will try to cast
  /// each value of the [List] binded, if the element cast fails will ignore it, by default if everything fails will
  /// return an empty [List].
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [sensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  List<T> getList<T>(String key, {bool sensitive = false}) {
    List<T> init = <T>[];

    dynamic value = _bindValue(<String>[key], caseSensitive: sensitive);
    try {
      init = (value as List<T>);
      return init;
    } catch (x) {
      List<dynamic> cast = value as List<dynamic>;
      for (dynamic value in cast) {
        try {
          T valueExpected = value as T;
          init.add(valueExpected);
        } catch (x) {
          continue;
        }
      }
      return init;
    }
  }

  /// Get a property value Specified by [key] not strict by casing, but if the bind fails will return [defaultValue].
  /// can fail by the property wasn't found or the cast failed.
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [defaultValue] Default value to return when the bind fails.
  T getDefault<T>(String key, T defaultValue) => _bindProperty(<String>[key], defaultValue);

  /// Get a property value Specified by [key] strict by string casing, but if the bind fails will return [defaultValue].
  /// can fail by the property wasn't found or the cast failed.
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [defaultValue] Default value to return when the bind fails.
  T getSensitive<T>(String key, T defaultValue) => _bindProperty(<String>[key], defaultValue, caseSensitive: true);

  /// Get a property value Specified by a [List] of [key] no strict by string casing, will return the first
  /// proeprty key the binder finds, but if the bind fails will return [defaultValue].
  /// can fail by the property wasn't found or the cast failed.
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [defaultValue] Default value to return when the bind fails.
  T getFallback<T>(List<String> fallback, T defaultValue) => _bindProperty(fallback, defaultValue);

  /// Get a property value Specified by a [List] of [key] strict by string casing, will return the first
  /// proeprty key the binder finds, but if the bind fails will return [defaultValue].
  /// can fail by the property wasn't found or the cast failed.
  ///
  /// [key] Specified [JObject] key to trace and bind the property value.
  ///
  /// [defaultValue] Default value to return when the bind fails.
  T getFallbackSensitive<T>(List<String> fallback, T defaultValue) => _bindProperty(fallback, defaultValue, caseSensitive: true);
}

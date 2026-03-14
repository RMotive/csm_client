import 'dart:typed_data' show Uint8List;

import 'package:csm_client_core/csm_client_core.dart' show DataMap, IEntity, TracedException;

/// {extension} for [int] type.
///
/// Adds custom extension methods to simplfy conversions and calculations with [int] type objects.
extension IntExtension on int {
  /// Gets the [int] value as a [Duration] object in {seconds}.
  Duration get secs => Duration(
        seconds: this,
      );

  /// Gets the [int] value as a [Duration] object in {milliseconds}.
  Duration get millisecs => Duration(
        milliseconds: this,
      );
}

///
final class _SupportedTypeConfiguration<T> {
  ///
  late Type type;

  ///
  final T defaultValue;

  ///
  T Function(Object value) convertion;

  _SupportedTypeConfiguration(this.defaultValue, this.convertion) {
    type = T;
  }
}

/// [extension] for [DataMap] type.
///
/// Adds custom extension methods to simplify conversions and calculations with [DataMap] type objects.
extension DataMapExtension on DataMap {
  /// Stores the current supported [Type]'s to auto cast and run specific sanitization.
  static final List<_SupportedTypeConfiguration<Object>> _supported = <_SupportedTypeConfiguration<Object>>[
    /// --> [DateTime] supported configurations
    _SupportedTypeConfiguration<DateTime>(
      DateTime(0),
      (Object value) => DateTime.parse(value.toString()),
    ),

    /// --> [String] supported configuration.
    _SupportedTypeConfiguration<String>(
      '',
      (Object value) => value.toString(),
    ),

    /// --> [int] supported configuration.
    _SupportedTypeConfiguration<int>(
      0,
      (Object value) => int.parse(value.toString()),
    ),

    /// --> [BigInt] supported configuration.
    _SupportedTypeConfiguration<BigInt>(
      BigInt.from(0),
      (Object value) => BigInt.parse(value.toString()),
    ),

    /// --> [DataMap] supported configuration.
    _SupportedTypeConfiguration<DataMap>(
      <String, Object?>{},
      (Object value) => value as DataMap,
    ),

    /// --> [bool] supported configuration.
    _SupportedTypeConfiguration<bool>(
      false,
      (Object value) => bool.parse(value.toString()),
    ),

    /// --> [Object] supported configuration.
    _SupportedTypeConfiguration<Object>(
      Object(),
      (Object value) => value,
    ),
  ];

  /// Gets the value of the given key from the [DataMap].
  ///
  ///
  /// [T] type expected for the value.
  ///
  /// [key] value key at the [DataMap].
  ///
  /// [strict] whether an exception should be thrown when the key is not found in the [DataMap].
  ///
  /// [caseSensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  T get<T>(String key, [T? defaultValue, bool strict = false, bool caseSensitive = false]) {
    final bool isNullable = null is T;

    /// Getting target [Key] and its [Value].
    bool keyExist = false;
    Object? keyValue;
    if (caseSensitive) {
      keyExist = containsKey(key);
      keyValue = keyExist ? this[key] : null;
    } else {
      for (MapEntry<String, Object?> mapEntry in entries) {
        final String uncKey = mapEntry.key.toLowerCase();

        if (uncKey == key.toLowerCase()) {
          keyExist = true;
          keyValue = mapEntry.value;
          break;
        }
      }
    }

    /// Validations when the [key] is not found.
    if ((!keyExist)) {
      if (strict) {
        throw TracedException('The given key($key) is not present in the current [DataMap] instance');
      }
      if (isNullable) {
        return (null as T);
      }
      if (defaultValue == null && !isNullable) {
        throw TracedException(
            'The given key ($key) was not found in the current [DataMap] instance, the expected type is not nullable and the default value given is nullable wrong configuration');
      }

      return defaultValue as T;
    }

    if (keyValue == null && isNullable) {
      return (null as T);
    }

    /// Getting the correct type configuration
    _SupportedTypeConfiguration<T>? typeConfiguration;
    for (_SupportedTypeConfiguration<Object> typeConfig in _supported) {
      if (!isNullable) {
        if (typeConfig.type == T) {
          typeConfiguration = typeConfig as _SupportedTypeConfiguration<T>;
          break;
        }

        continue;
      }

      String bruteGeneric = T.toString();
      bruteGeneric = bruteGeneric.substring(0, bruteGeneric.length - 1);

      if (bruteGeneric == typeConfig.type.toString()) {
        typeConfiguration = typeConfig as _SupportedTypeConfiguration<T>;
        break;
      }
    }

    if (typeConfiguration == null) {
      throw TracedException('Unsupported: This method doesn\'t allow binding for $T');
    }

    if (keyValue == null) {
      return typeConfiguration.defaultValue;
    }

    return typeConfiguration.convertion(keyValue);
  }

  /// Gets the value of the given key from the [DataMap] as an [EntityI] implementation for direct decoding, since there's impossible to detect whether the generic [T] is nullable
  /// this method can only return nullable [T].
  ///
  ///
  /// [T] type of the [EntityI] object.
  ///
  /// [factory] method to generate a clean [EntityI] object to apply decoding process.
  ///
  /// [key] value key at the [DataMap].
  ///
  /// [strict] whether an exception should be thrown when the key is not found in the [DataMap].
  ///
  /// [caseSensitive] Specifies if the key searching in the object should consider the specific casing of the words.
  T? getEntity<T extends IEntity<T>>(
    T Function() factory,
    String key, [
    T? defaultValue,
    bool strict = false,
    bool caseSensitive = false,
  ]) {
    DataMap? dm = get(key, <String, Object>{}, strict, caseSensitive);

    if (dm == null) return null;

    T entity = factory();
    entity.decode(dm);

    return entity;
  }

  /// Gets the list value of the given key from the [DataMap].
  ///
  ///
  /// [key] Specified [DataMap] key to trace and bind the property value.
  ///
  /// [strict] whether an exception should be thrown when the key is not found in the [DataMap].
  ///
  /// [caseSensitive] wheter the key matching must consider word casing.
  List<T> getList<T>(String key, [List<T>? defaultValue, bool strict = false, bool caseSensitive = false]) {
    late final List<T> cacheList;

    final Object? rawList = get(key, strict, caseSensitive);
    if (rawList == null) {
      if (defaultValue != null) {
        return defaultValue;
      }

      throw TracedException('Value is null and no defaultValue configured wrong configuration');
    }

    try {
      cacheList = (rawList as List<dynamic>).cast<T>();
      return cacheList;
    } catch (exception) {
      late final List<Object?> castedObjectList;

      try {
        castedObjectList = rawList as List<Object?>;
      } catch (exception) {
        throw TracedException('Unsupported data type casting for ($T)');    
      }

      cacheList = <T>[];
      for (Object? value in castedObjectList) {
        try {
          T valueAsExpect = value as T;
          cacheList.add(valueAsExpect);
        } catch (x) {
          continue;
        }
      }
    }

    return cacheList;
  }
}

/// [extension] for [String] type.
///
/// Adds custom extension methods to simplify conversions and calculations with [String] type objects.
extension StringExtension on String {
  /// Returns whether the current [String] starts with uppercase.
  bool get isStartUpper {
    final String startLetter = substring(0, 1);
    return startLetter.toUpperCase() == startLetter;
  }

  /// Converts the current [String] into a new [String] object that starts with uppercase.
  String get toStartUpper {
    if (isStartUpper) return this;
    final String startLetter = substring(0, 1);
    return '${startLetter.toUpperCase()}${substring(1, length)}';
  }

  /// Converts the current [String] into a [Uint8List] using base64 convertion.
  Uint8List get bytes {
    return Uint8List.fromList(codeUnits);
  }
}

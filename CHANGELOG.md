# Changelog

Common.

## 5.0.1

- Added JObject utils for binding.

        1. Now can be binded [bool] properties.
        2. Now can be binded [Map<String, dynamic>] properties [{JObject}]
        3. Now can be binded [List<Map<String, dynamic>>] proeprties [{List<JObject>}]

## 5.0.0

- Added serialization support along vm and jsinterop platforms where [dart:mirrors] aren´t allowed,
throughout abstraction bypassing of decoders or mirroring.

        1. NOTE: For jsinterop platforms is required to provide [decoders] implementations.
        2. NOTE: For native platforms [dart:mirrors] at the current date doesn't allow instancing generic factories classes.

## 1.0.0

- Initial version.

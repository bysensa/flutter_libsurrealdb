library libsurrealdb;

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import './bindings.dart';

const DYNAMIC_LIBRARY_FILE_NAME_ANDROID = "libsurrealdb.so";
const DYNAMIC_LIBRARY_FILE_NAME_MACOS = "libsurrealdb.dylib";
const TEST_ENV_VARIABLE = "FLUTTER_TEST";

/// Wraps the native functions and converts specific data types in order to
/// handle C strings.

class Surreal {
  static final SurrealBindings _bindings =
      SurrealBindings(Surreal._loadLibrary());

  static DynamicLibrary _loadLibrary() {
    return Platform.isAndroid
        ? DynamicLibrary.open(DYNAMIC_LIBRARY_FILE_NAME_ANDROID)
        : DynamicLibrary.process();
  }

  /// Computes a greeting for the given name using the native function
  static String greet(String name) {
    final ptrName = name.toNativeUtf8().cast<Char>();

    // Native call
    final ptrResult = _bindings.rust_greeting(ptrName);

    // Cast the result pointer to a Dart string
    final result = ptrResult.cast<Utf8>().toDartString();

    // Clone the given result, so that the original string can be freed
    final resultCopy = "" + result;

    // Free the native value
    Surreal._free(result);

    return resultCopy;
  }

  /// Releases the memory allocated to handle the given (result) value
  static void _free(String value) {
    final ptr = value.toNativeUtf8().cast<Char>();
    return _bindings.rust_cstr_free(ptr);
  }
}

// Common

extension on String {
  Pointer<Char> get asPointer => toNativeUtf8().cast<Char>();
}

// SurrealDB

class SurrealLib {
  static var _inTests = false;

  static final SurrealBindings _bindings = () {
    late final DynamicLibrary dylib;
    if (Platform.isAndroid) {
      dylib = DynamicLibrary.open(DYNAMIC_LIBRARY_FILE_NAME_ANDROID);
    } else if (Platform.isIOS) {
      dylib = DynamicLibrary.process();
    } else if (Platform.isMacOS && _inTests) {
      dylib = DynamicLibrary.open(DYNAMIC_LIBRARY_FILE_NAME_MACOS);
    } else if (Platform.isMacOS && !_inTests) {
      dylib = DynamicLibrary.process();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
    return SurrealBindings(dylib);
  }();

  @visibleForTesting
  SurrealLib.forTesting() {
    _inTests = true;
    _bindings;
  }
}

class Session {
  Pointer<SurrealSession>? _sessionPtr;

  Session._(this._sessionPtr);

  bool get isClosed => _sessionPtr == null;
  bool get isNotClosed => !isClosed;

  factory Session.forKv() {
    final ptr = SurrealLib._bindings.session_for_kv_new();
    return Session._(ptr);
  }

  factory Session.forNs(String ns) {
    final ptr = SurrealLib._bindings.session_for_ns_new(ns.asPointer);
    return Session._(ptr);
  }

  factory Session.forDb(String ns, String db) {
    final ptr = SurrealLib._bindings.session_for_db_new(
      ns.asPointer,
      db.asPointer,
    );
    return Session._(ptr);
  }

  factory Session.forSc(String ns, String db, String sc) {
    final ptr = SurrealLib._bindings.session_for_sc_new(
      ns.asPointer,
      db.asPointer,
      sc.asPointer,
    );
    return Session._(ptr);
  }

  void withNs(String ns) {
    assert(isNotClosed);
    final newPointer = SurrealLib._bindings.session_set_with_ns(
      _sessionPtr!,
      ns.asPointer,
    );
    _sessionPtr = newPointer;
  }

  void withDb(String db) {
    assert(isNotClosed);
    final newPointer = SurrealLib._bindings.session_set_with_db(
      _sessionPtr!,
      db.asPointer,
    );
    _sessionPtr = newPointer;
  }

  void close() {
    if (isClosed) {
      return;
    }
    SurrealLib._bindings.session_free(_sessionPtr!);
  }
}

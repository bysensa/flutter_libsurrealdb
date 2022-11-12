// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Dart bindings to call mylib functions
class SurrealBindings {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  SurrealBindings(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  SurrealBindings.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  ffi.Pointer<ffi.Char> rust_greeting(
    ffi.Pointer<ffi.Char> to,
  ) {
    return _rust_greeting(
      to,
    );
  }

  late final _rust_greetingPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Char>)>>('rust_greeting');
  late final _rust_greeting = _rust_greetingPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Char>)>();

  void rust_cstr_free(
    ffi.Pointer<ffi.Char> s,
  ) {
    return _rust_cstr_free(
      s,
    );
  }

  late final _rust_cstr_freePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'rust_cstr_free');
  late final _rust_cstr_free =
      _rust_cstr_freePtr.asFunction<void Function(ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<SurrealSession> session_for_kv_new() {
    return _session_for_kv_new();
  }

  late final _session_for_kv_newPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<SurrealSession> Function()>>(
          'session_for_kv_new');
  late final _session_for_kv_new = _session_for_kv_newPtr
      .asFunction<ffi.Pointer<SurrealSession> Function()>();

  ffi.Pointer<SurrealSession> session_for_ns_new(
    ffi.Pointer<ffi.Char> ns,
  ) {
    return _session_for_ns_new(
      ns,
    );
  }

  late final _session_for_ns_newPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SurrealSession> Function(
              ffi.Pointer<ffi.Char>)>>('session_for_ns_new');
  late final _session_for_ns_new = _session_for_ns_newPtr.asFunction<
      ffi.Pointer<SurrealSession> Function(ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<SurrealSession> session_for_db_new(
    ffi.Pointer<ffi.Char> ns,
    ffi.Pointer<ffi.Char> db,
  ) {
    return _session_for_db_new(
      ns,
      db,
    );
  }

  late final _session_for_db_newPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SurrealSession> Function(ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>)>>('session_for_db_new');
  late final _session_for_db_new = _session_for_db_newPtr.asFunction<
      ffi.Pointer<SurrealSession> Function(
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<SurrealSession> session_for_sc_new(
    ffi.Pointer<ffi.Char> ns,
    ffi.Pointer<ffi.Char> db,
    ffi.Pointer<ffi.Char> sc,
  ) {
    return _session_for_sc_new(
      ns,
      db,
      sc,
    );
  }

  late final _session_for_sc_newPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SurrealSession> Function(
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>)>>('session_for_sc_new');
  late final _session_for_sc_new = _session_for_sc_newPtr.asFunction<
      ffi.Pointer<SurrealSession> Function(ffi.Pointer<ffi.Char>,
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<SurrealSession> session_set_with_ns(
    ffi.Pointer<SurrealSession> ptr,
    ffi.Pointer<ffi.Char> ns,
  ) {
    return _session_set_with_ns(
      ptr,
      ns,
    );
  }

  late final _session_set_with_nsPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SurrealSession> Function(ffi.Pointer<SurrealSession>,
              ffi.Pointer<ffi.Char>)>>('session_set_with_ns');
  late final _session_set_with_ns = _session_set_with_nsPtr.asFunction<
      ffi.Pointer<SurrealSession> Function(
          ffi.Pointer<SurrealSession>, ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<SurrealSession> session_set_with_db(
    ffi.Pointer<SurrealSession> ptr,
    ffi.Pointer<ffi.Char> db,
  ) {
    return _session_set_with_db(
      ptr,
      db,
    );
  }

  late final _session_set_with_dbPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SurrealSession> Function(ffi.Pointer<SurrealSession>,
              ffi.Pointer<ffi.Char>)>>('session_set_with_db');
  late final _session_set_with_db = _session_set_with_dbPtr.asFunction<
      ffi.Pointer<SurrealSession> Function(
          ffi.Pointer<SurrealSession>, ffi.Pointer<ffi.Char>)>();

  void session_free(
    ffi.Pointer<SurrealSession> ptr,
  ) {
    return _session_free(
      ptr,
    );
  }

  late final _session_freePtr = _lookup<
          ffi.NativeFunction<ffi.Void Function(ffi.Pointer<SurrealSession>)>>(
      'session_free');
  late final _session_free =
      _session_freePtr.asFunction<void Function(ffi.Pointer<SurrealSession>)>();
}

class SurrealSession extends ffi.Opaque {}
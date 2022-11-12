import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:libsurrealdb/libsurrealdb.dart';

void main() {
  setUpAll(() {
    SurrealLib.forTesting();
  });

  test('should create session for kv', () {
    final session = Session.forKv();
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.close();
  });

  test('should create session for ns', () {
    final session = Session.forNs('test');
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.close();
  });

  test('should create session for db', () {
    final session = Session.forDb('test', 'test');
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.close();
  });

  test('should create session for sc', () {
    final session = Session.forSc('test', 'test', 'test');
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.close();
  });

  test('should set ns in session', () {
    final session = Session.forKv();
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.withNs('test');
    session.withNs('some');
    session.close();
  });

  test('should set db in session', () {
    final session = Session.forKv();
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.withDb('test');
    session.withDb('some');
    session.close();
  });

  test('should set ns and db in session', () {
    final session = Session.forKv();
    expect(session, isNotNull);
    expect(session.isClosed, isFalse);
    session.withNs('test');
    session.withDb('some');
    session.close();
  });
}

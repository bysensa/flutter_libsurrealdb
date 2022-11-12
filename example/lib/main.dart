import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:libsurrealdb/libsurrealdb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _callGreet();
  }

  void _callGreet() {
    final query = r"USE NS test DB test;SELECT * from person;";
    print(Surreal.greet(query));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running on:'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _callGreet,
        ),
      ),
    );
  }
}

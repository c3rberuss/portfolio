import 'package:bookshop/src/app.dart';
import 'package:bookshop/src/repositories/preferences_repository_impl.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = PreferencesRepositoryImpl();

  runApp(App(preferences: _preferences));
}

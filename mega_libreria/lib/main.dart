import 'package:flutter/material.dart';
import 'package:megalibreria/src/app.dart';
import 'package:megalibreria/src/repositories/preferences_repository_impl.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = PreferencesRepositoryImpl();

  runApp(App(preferences: _preferences));

}
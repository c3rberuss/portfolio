import 'package:flutter/material.dart';
import 'package:services/src/app.dart';
import 'package:services/src/repositories/spreferences_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = SPreferencesRepositoryImpl();

  runApp(
    ServicesApp(
      preferences: _preferences,
    ),
  );
}

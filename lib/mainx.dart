import 'package:flutter/material.dart';
import 'package:health_and_hope/src/app.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferencesUserApp();
  HelpersAppsColors();
  await prefs.initPrefs();
  // Intl.defaultLocale = 'es';
  runApp(AppSaludEsperanza());
}

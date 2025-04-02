import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';

void main() async {
  // 1. Preserve the native splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 2. Init Local Storage
  // Todo: Add your local storage initialization here

  // 3. Initialize Firebase
  // Todo: Add your Firebase initialization here

  // 4. Initialize Authentication
  // Todo: Add your authentication initialization here

  // 5. Remove the splash screen after everything is loaded
  FlutterNativeSplash.remove();

  runApp(const App());
}
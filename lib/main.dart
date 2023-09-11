import 'dart:async';

import 'package:book_store/core/config/app_config.dart';
import 'package:book_store/core/util/log_utils.dart';
import 'package:book_store/features/my_app/my_app.dart';
import 'package:book_store/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runZonedGuarded(
      _runMyApp,
      (error, stackTrace) => _reportError(error: error, stackTrace: stackTrace),
    );

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppConfig.getInstance().init();
  runApp(const MyApp());
}

void _reportError({required error, required StackTrace stackTrace}) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');
  // FirebaseCrashlytics.instance.recordError(error, stackTrace);
}

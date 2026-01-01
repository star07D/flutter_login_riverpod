import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    await FirebaseAuth.instance.authStateChanges().first;

    runApp(const ProviderScope(child: MyApp()));
  }



  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

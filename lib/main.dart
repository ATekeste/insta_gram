import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_gram/features/auth/screens/login_page.dart';
import 'package:insta_gram/features/home/home_page.dart';
import 'package:insta_gram/features/state/auth/providers/is_loggedin_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          var isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}

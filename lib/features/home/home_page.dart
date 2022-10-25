import 'package:flutter/material.dart';
import 'package:insta_gram/features/auth/screens/login_page.dart';
import 'package:insta_gram/features/state/auth/backend/authenticator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Authenticator().logOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const LoginPage();
                },
              ));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

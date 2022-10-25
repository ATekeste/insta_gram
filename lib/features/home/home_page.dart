import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_gram/features/state/auth/providers/auth_state_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).logOut();
                },
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth/providers/auth_state_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
                child: const Text('Sign in with Google'),
              ),
              TextButton(
                onPressed:
                    ref.read(authStateProvider.notifier).logInWithFacebook,
                child: const Text('Sign in with Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

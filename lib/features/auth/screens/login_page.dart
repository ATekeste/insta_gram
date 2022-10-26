import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 68.0),
                child: Text(
                  'Welcome to Insta clone',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
                label: const Text('Sign in with Google'),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.redAccent,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 44),
                ),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed:
                    ref.read(authStateProvider.notifier).logInWithFacebook,
                label: const Text('Sign in with Facebook'),
                icon: const FaIcon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.blue,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 44),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

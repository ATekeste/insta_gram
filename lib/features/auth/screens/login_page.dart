import 'package:flutter/material.dart';
import 'package:insta_gram/features/common/utility.dart';
import 'package:insta_gram/features/home/home_page.dart';
import 'package:insta_gram/features/state/auth/backend/authenticator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                final result = await Authenticator().loginWithGoogle();
                result.log();

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              },
              child: const Text('Sign in with Google'),
            ),
            TextButton(
              onPressed: () async {
                final result = await Authenticator().loginWithFacebook();
                result.log();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              },
              child: const Text('Sign in with Facebook'),
            ),
          ],
        ),
      ),
    );
  }
}

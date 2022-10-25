import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_gram/features/state/auth/backend/authenticator.dart';
import 'package:insta_gram/features/state/auth/models/auth_results.dart';
import 'package:insta_gram/features/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }
  Future<void> logInWithGoogle() async {
    state = state.copyWithIsLoading(true);

    var result = await _authenticator.loginWithGoogle();
    var userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {}
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }
}

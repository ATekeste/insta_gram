import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_gram/features/state/auth/backend/authenticator.dart';
import 'package:insta_gram/features/state/auth/models/auth_results.dart';
import 'package:insta_gram/features/state/auth/models/auth_state.dart';
import 'package:insta_gram/features/state/posts/typedefs/user_id.dart';
import 'package:insta_gram/features/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

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

    if (result == AuthResult.success && userId != null) {
      await saveUserinfo(userId: userId);
    }
    state = AuthState(
      userId: userId,
      result: result,
      isLoading: false,
    );
  }

  Future<void> logInWithFacebook() async {
    state = state.copyWithIsLoading(true);

    var result = await _authenticator.loginWithFacebook();
    var userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserinfo(userId: userId);
    }
    state = AuthState(
      userId: userId,
      result: result,
      isLoading: false,
    );
  }

  Future<void> saveUserinfo({required UserId userId}) async {
    _userInfoStorage.saveUserInfo(
      userId: userId,
      displayName: _authenticator.displayName,
      email: _authenticator.email,
    );
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }
}

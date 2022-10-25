import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_gram/features/state/auth/models/auth_results.dart';

import 'auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>(
  (ref) {
    var authState = ref.watch(authStateProvider);

    return authState.result == AuthResult.success;
  },
);

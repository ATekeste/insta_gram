import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth/providers/auth_state_provider.dart';

var isLoadingProvider = Provider<bool>((ref) {
  var authState = ref.watch(authStateProvider);

  return authState.isLoading;
});

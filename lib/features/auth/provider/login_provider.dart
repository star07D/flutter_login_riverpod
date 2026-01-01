import 'package:flutter_riverpod/flutter_riverpod.dart';

/// STATE
class LoginState {
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// NOTIFIER
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@test.com' && password == '123456') {
      state = state.copyWith(isLoading: false);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid email or password',
      );
    }
  }
}

final loginProvider =
StateNotifierProvider<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(),
);

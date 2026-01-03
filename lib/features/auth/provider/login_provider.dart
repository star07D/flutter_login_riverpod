import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider =
StateNotifierProvider<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(),
);

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

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // LOGIN — EXISTING USERS ONLY
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        state = state.copyWith(
          errorMessage: 'User not registered. Please sign up.',
        );
      } else if (e.code == 'wrong-password') {
        state = state.copyWith(
          errorMessage: 'Wrong password.',
        );
      } else {
        state = state.copyWith(
          errorMessage: e.message,
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // SIGNUP — NEW USERS ONLY
  Future<void> signup({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // LOGOUT — RESET EVERYTHING
  Future<void> logout() async {
    await _auth.signOut();
    state = const LoginState();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }




  final _auth = FirebaseAuth.instance;

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

      state = state.copyWith(isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message ?? 'Login failed',
      );
    }
  }
}

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});


final loginProvider =
StateNotifierProvider<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(),
);

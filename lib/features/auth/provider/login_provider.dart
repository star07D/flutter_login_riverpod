import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_state.dart';

final loginProvider =
StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState());

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Optional
    }
  }

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

      state = state.copyWith(isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message ?? 'Signup failed',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong',
      );
    }
  }
  Future<void> logout() async {
    await _auth.signOut();
    state = const LoginState();
  }
}

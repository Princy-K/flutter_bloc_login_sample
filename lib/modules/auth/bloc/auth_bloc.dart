import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthState.initial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ResetAuth>(_onResetAuth);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<AuthState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onResetAuth(ResetAuth event, Emitter<AuthState> emit) {
    emit(state.copyWith(isSuccess: false, errorMessage: null));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthState> emit) async {
    if (!state.isValid) {
      emit(state.copyWith(errorMessage: 'Invalid form input'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await _createAccountOrLogin();
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: _mapFirebaseErrorToMessage(e),
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Unexpected error: ${e.toString()}',
      ));
    }
  }

  Future<void> _createAccountOrLogin() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: state.email.trim(),
          password: state.password.trim(),
        );
      } else {
        rethrow;
      }
    }
  }

  String _mapFirebaseErrorToMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak';
      case 'email-already-in-use':
        return 'Email already in use. Logging in...';
      case 'user-not-found':
      case 'wrong-password':
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid credentials';
      default:
        return 'Authentication failed: ${e.message ?? e.code}';
    }
  }
}

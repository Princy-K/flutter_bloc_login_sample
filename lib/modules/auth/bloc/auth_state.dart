part of 'auth_bloc.dart';

class AuthState {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final bool showPassword;

  bool get isValid => email.contains('@') && password.length >= 6;

  AuthState(
      {required this.email,
      required this.password,
      required this.isSubmitting,
      required this.isSuccess,
      this.errorMessage,
      required this.showPassword});

  factory AuthState.initial() => AuthState(
        email: '',
        password: '',
        isSubmitting: false,
        isSuccess: false,
        errorMessage: null,
        showPassword: false,
      );

  AuthState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? showPassword,
    String? errorMessage,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      showPassword: showPassword ?? this.showPassword,
      errorMessage: errorMessage,
    );
  }
}

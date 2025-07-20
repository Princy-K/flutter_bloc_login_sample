part of 'auth_bloc.dart';

sealed class AuthEvent {}

class EmailChanged extends AuthEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged(this.password);
}

class TogglePasswordVisibility extends AuthEvent {}

class LoginSubmitted extends AuthEvent {}

class ResetAuth extends AuthEvent {}
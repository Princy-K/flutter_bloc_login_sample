import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(showPassword: !state.showPassword));
    });

    on<ResetAuth>((event, emit) {
      emit(state.copyWith(isSuccess: false, errorMessage: null));
    });

    on<LoginSubmitted>((event, emit) async {
      if (!state.isValid) {
        emit(state.copyWith(errorMessage: 'Invalid form input'));
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      await Future.delayed(Duration(seconds: 2)); // Simulated API

      if (state.email == 'admin@test.com' && state.password == '123456') {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: 'Invalid email or password',
        ));
      }
    });
  }
}

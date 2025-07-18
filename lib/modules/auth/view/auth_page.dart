import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/modules/auth/bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('AUTH BUILD');

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (prev, curr) =>
              !prev.isSuccess && curr.isSuccess ||
              prev.errorMessage != curr.errorMessage,
          listener: (context, state) {
            debugPrint('LISTENER');
            if (state.isSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Login Success')));
              context.read<AuthBloc>().add(ResetAuth());
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          buildWhen: (prev, curr) =>
              prev.isSubmitting != curr.isSubmitting ||
              prev.isValid != curr.isValid,
          builder: (context, state) {
            debugPrint('BUILDER');
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Email
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (prev, curr) => prev.email != curr.email,
                      builder: (context, state) {
                        debugPrint('EMAIL');
                        return TextFormField(
                          initialValue: state.email,
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (value) =>
                              context.read<AuthBloc>().add(EmailChanged(value)),
                          validator: (value) =>
                              value != null && value.contains('@')
                                  ? null
                                  : 'Enter a valid email',
                        );
                      },
                    ),

                    /// Password
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (prev, curr) =>
                          prev.password != curr.password ||
                          prev.showPassword != curr.showPassword,
                      builder: (context, state) {
                        debugPrint('PASSWORD');
                        return TextFormField(
                          initialValue: state.password,
                          obscureText: !state.showPassword,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(TogglePasswordVisibility());
                                },
                              )),
                          onChanged: (value) => context
                              .read<AuthBloc>()
                              .add(PasswordChanged(value)),
                          validator: (value) =>
                              value != null && value.length >= 6
                                  ? null
                                  : 'Minimum 6 characters',
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    /// Submit button
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (prev, curr) =>
                          prev.isSubmitting != curr.isSubmitting ||
                          prev.isValid != curr.isValid,
                      builder: (context, state) {
                        return state.isSubmitting
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: state.isValid
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<AuthBloc>()
                                              .add(LoginSubmitted());
                                        }
                                      }
                                    : null,
                                child: Text('Login'),
                              );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

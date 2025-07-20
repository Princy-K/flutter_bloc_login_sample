import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/core/extentions/margin_extention.dart';
import 'package:flutter_bloc_example/core/extentions/media_query_extention.dart';
import 'package:flutter_bloc_example/core/extentions/padding_extention.dart';
import 'package:flutter_bloc_example/core/extentions/sized_box_extention.dart';
import 'package:flutter_bloc_example/modules/auth/bloc/auth_bloc.dart';

import '../../../widgets/custom_edit_field.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('AUTH BUILD');

    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SafeArea(
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
                padding: context.paddingAllResponsive(0.08),
                child: ListView(
                  children: [
                    Padding(
                      padding: context.verticalPadding(0.04),
                      child: Text('SPEARGA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: context.verticalPadding(0.02),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Login to your account',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /// Email
                          BlocBuilder<AuthBloc, AuthState>(
                            buildWhen: (prev, curr) => prev.email != curr.email,
                            builder: (context, state) {
                              debugPrint('EMAIL');
                              return CustomEditField(
                                  hintText: 'Email',
                                  initialValue: state.email,
                                  onChanged: (value) => context
                                      .read<AuthBloc>()
                                      .add(EmailChanged(value)),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Email is required';
                                    }
                                    final emailRegex = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                    if (!emailRegex.hasMatch(value.trim())) {
                                      return 'Enter a valid email';
                                    }

                                    return null;
                                  });
                            },
                          ),

                          /// Password
                          BlocBuilder<AuthBloc, AuthState>(
                            buildWhen: (prev, curr) =>
                                prev.password != curr.password ||
                                prev.showPassword != curr.showPassword,
                            builder: (context, state) {
                              debugPrint('PASSWORD');
                              return CustomEditField(
                                  hintText: 'Password',
                                  initialValue: state.password,
                                  obscureText: !state.showPassword,
                                  suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity(
                                        vertical: -4, horizontal: -4),
                                    icon: Icon(
                                      state.showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<AuthBloc>()
                                          .add(TogglePasswordVisibility());
                                    },
                                  ),
                                  onChanged: (value) => context
                                      .read<AuthBloc>()
                                      .add(PasswordChanged(value)),
                                  validator: (value) =>
                                      value != null && value.length >= 6
                                          ? null
                                          : 'Minimum 6 characters');
                            },
                          ),

                          context.spaceH(0.05),

                          /// Submit button
                          BlocBuilder<AuthBloc, AuthState>(
                            buildWhen: (prev, curr) =>
                                prev.isSubmitting != curr.isSubmitting ||
                                prev.isValid != curr.isValid,
                            builder: (context, state) {
                              return state.isSubmitting
                                  ? CircularProgressIndicator()
                                  : SizedBox(
                                      width: context.screenWidth,
                                      height: context.screenHeight * 0.08,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.purple,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<AuthBloc>()
                                                .add(LoginSubmitted());
                                          }
                                        },
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
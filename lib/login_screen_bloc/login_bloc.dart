import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {

    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email,
          status: LoginStatus.initial,
          errorMessage: '',
        ),
      );
    });


    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: event.password,
          status: LoginStatus.initial,
          errorMessage: '',
        ),
      );
    });


    on<LoginButtonPressed>((event, emit) async {

      final email = state.email.trim();
      final password = state.password;

      if (email.isEmpty && password.isEmpty) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage:
            'Email and password are required.',
          ),
        );

        return;
      }


      if (email.isEmpty) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage: 'Please enter your email.',
          ),
        );

        return;
      }

      if (password.isEmpty) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage: 'Please enter your password.',
          ),
        );

        return;
      }

      if (!email.contains('@gmail.com')) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage:
            'Please enter a valid email address.',
          ),
        );

        return;
      }

      if (password.length < 6) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage:
            'Password must be at least 6 characters.',
          ),
        );

        return;
      }


      emit(
        state.copyWith(
          status: LoginStatus.loading,
          errorMessage: '',
        ),
      );

      await Future.delayed(
        const Duration(seconds: 2),
      );

      emit(
        state.copyWith(
          status: LoginStatus.success,
          errorMessage: '',
        ),
      );
    });
  }
}
import 'package:bloc/bloc.dart';
import 'package:bookia/feature/auth/data/Repo/auth_repo.dart';
import 'package:bookia/feature/auth/data/model/forgetpass_model.dart';
import 'package:meta/meta.dart';

part 'authcubit_state.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  AuthcubitCubit() : super(AuthcubitInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(loginLoadingState());

    try {
      final response = await AuthRepo.Login(
        email: email,
        password: password,
      );

      if (response) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('Login failed. Please try again.'));
      }
    } catch (e) {
      emit(
        LoginErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    emit(registerLoadingState());

    try {
      final response = await AuthRepo.Register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        city: city,
        address: address,
      );

      if (response) {
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState('Registration failed. Please try again.'));
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }


  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(forgotPasswordLoadingState());

    try {
      final response = await AuthRepo.forgotPassword(email: email);
      emit(ForgotPasswordSuccessState(response));
    } catch (e) {
      emit(
        ForgotPasswordErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }


  Future<void> checkForgetPassword({
    required String email,
    required String code,
  }) async {
    emit(CheckOtpLoadingState());

    try {
      final success = await AuthRepo.checkForgetPassword(
        email: email,
        code: code,
      );

      if (success) {
        emit(CheckOtpSuccessState());
      } else {
        emit(CheckOtpErrorState('Invalid or expired code. Please try again.'));
      }
    } catch (e) {
      emit(
        CheckOtpErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }


  Future<void> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoadingState());

    try {
      final success = await AuthRepo.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      if (success) {
        emit(ResetPasswordSuccessState());
      } else {
        emit(ResetPasswordErrorState('Password reset failed. Please try again.'));
      }
    } catch (e) {
      emit(
        ResetPasswordErrorState(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}

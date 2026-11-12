part of 'authcubit_cubit.dart';

@immutable
sealed class AuthcubitState {}

final class AuthcubitInitial extends AuthcubitState {}


final class loginLoadingState extends AuthcubitState {}

final class LoginSuccessState extends AuthcubitState {}

final class LoginErrorState extends AuthcubitState {
  final String message;

  LoginErrorState(this.message);
}

final class registerLoadingState extends AuthcubitState {}

final class RegisterSuccessState extends AuthcubitState {}

final class RegisterErrorState extends AuthcubitState {
  final String message;

  RegisterErrorState(this.message);
}


class forgotPasswordLoadingState extends AuthcubitState {}

class ForgotPasswordSuccessState extends AuthcubitState {
  final ForgotPasswordModel response;

  ForgotPasswordSuccessState(this.response);
}

class ForgotPasswordErrorState extends AuthcubitState {
  final String message;

  ForgotPasswordErrorState(this.message);
}

class CheckOtpLoadingState extends AuthcubitState {}

class CheckOtpSuccessState extends AuthcubitState {}

class CheckOtpErrorState extends AuthcubitState {
  final String message;

  CheckOtpErrorState(this.message);
}


class ResetPasswordLoadingState extends AuthcubitState {}

class ResetPasswordSuccessState extends AuthcubitState {}

class ResetPasswordErrorState extends AuthcubitState {
  final String message;

  ResetPasswordErrorState(this.message);
}

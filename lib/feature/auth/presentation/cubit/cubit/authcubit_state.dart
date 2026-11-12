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
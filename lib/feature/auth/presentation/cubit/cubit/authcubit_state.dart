part of 'authcubit_cubit.dart';

@immutable
sealed class AuthcubitState {}

final class AuthcubitInitial extends AuthcubitState {}

final class loginLoadingState extends AuthcubitState {}
final class LoginSuccessState extends AuthcubitState {}
final class LoginErrorState extends AuthcubitState {}


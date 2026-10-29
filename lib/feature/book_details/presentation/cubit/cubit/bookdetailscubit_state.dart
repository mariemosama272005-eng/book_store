part of 'bookdetailscubit_cubit.dart';

@immutable
sealed class BookdetailscubitState {}

final class BookdetailscubitInitial extends BookdetailscubitState {}

final class BookdetailscubitLoading extends BookdetailscubitState {}

final class BookdetailscubitError extends BookdetailscubitState {}

final class BookdetailscubitSuccess extends BookdetailscubitState {
  final Data details;

  BookdetailscubitSuccess(this.details);
}
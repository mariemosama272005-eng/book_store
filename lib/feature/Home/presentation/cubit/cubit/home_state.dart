part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class getbestsellerLoading extends HomeState {}
final class getbestsellerError extends HomeState {}
final class getbestsellerSuccess extends HomeState {
   final List<Products>? products;

getbestsellerSuccess(this.products);
}

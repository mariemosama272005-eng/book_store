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

final class SearchInitial extends HomeState {}
final class SearchLoading extends HomeState {}
final class SearchError extends HomeState {}
final class SearchSuccess extends HomeState {
  final List<Products>?products;
  SearchSuccess(this.products);
}

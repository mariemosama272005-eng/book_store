part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

// =========================
// INITIAL
// =========================
final class CartInitial extends CartState {}

// =========================
// SHOW CART
// =========================
final class CartLoading extends CartState {}

final class CartError extends CartState {
  final String? message;

  CartError([this.message]);
}

final class CartSuccess extends CartState {
  final Data cartData;

  CartSuccess(this.cartData);
}

// =========================
// UPDATE CART
// =========================
final class CartUpdateLoading extends CartState {
  final Data cartData;
  final int? updatingItemId;

  CartUpdateLoading(this.cartData, {this.updatingItemId});
}

final class CartUpdateSuccess extends CartState {
  final Data cartData;

  CartUpdateSuccess(this.cartData);
}

final class CartUpdateError extends CartState {
  final Data cartData;
  final String? message;

  CartUpdateError(this.cartData, [this.message]);
}

// =========================
// REMOVE CART
// =========================
final class CartRemoveLoading extends CartState {
  final Data cartData;
  final int? removingItemId;

  CartRemoveLoading(this.cartData, {this.removingItemId});
}

final class CartRemoveSuccess extends CartState {
  final Data cartData;

  CartRemoveSuccess(this.cartData);
}

final class CartRemoveError extends CartState {
  final Data cartData;
  final String? message;

  CartRemoveError(this.cartData, [this.message]);
}

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

final class CartError extends CartState {}

final class CartSuccess extends CartState {
  final Data cartData;

  CartSuccess(this.cartData);
}

// =========================
// UPDATE CART
// =========================

final class CartUpdateLoading extends CartState {
  final Data cartData;

  CartUpdateLoading(this.cartData);
}

final class CartUpdateSuccess extends CartState {
  final Data cartData;

  CartUpdateSuccess(this.cartData);
}

final class CartUpdateError extends CartState {
  final Data cartData;

  CartUpdateError(this.cartData);
}

// =========================
// REMOVE CART
// =========================

final class CartRemoveLoading extends CartState {
  final Data cartData;

  CartRemoveLoading(this.cartData);
}

final class CartRemoveSuccess extends CartState {
  final Data cartData;

  CartRemoveSuccess(this.cartData);
}

final class CartRemoveError extends CartState {
  final Data cartData;

  CartRemoveError(this.cartData);
}
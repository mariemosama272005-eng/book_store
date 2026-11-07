import 'package:bloc/bloc.dart';
import 'package:bookia/feature/cart/data/model/cart_model.dart';
import 'package:bookia/feature/cart/data/repo/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  // =========================
  // SHOW CART
  // =========================

  Future<void> showCart() async {
    emit(CartLoading());

    final res = await CartRepo.showCart();

    if (res != null) {
      emit(CartSuccess(res));
    } else {
      emit(CartError());
    }
  }

  // =========================
  // UPDATE CART
  // =========================

  Future<void> updateCart({
    required int itemId,
    required int quantity,
  }) async {
    final currentData = _getCurrentCartData();

    if (currentData == null) {
      return;
    }

    if (quantity < 1) {
      return;
    }

    emit(CartUpdateLoading(currentData));

    final res = await CartRepo.updateCart(
      itemId: itemId,
      quantity: quantity,
    );

    if (res != null) {
      emit(CartUpdateSuccess(res));
    } else {
      emit(CartUpdateError(currentData));
    }
  }

  // =========================
  // REMOVE FROM CART
  // =========================

  Future<void> removeFromCart({
    required int itemId,
  }) async {
    final currentData = _getCurrentCartData();

    if (currentData == null) {
      return;
    }

    emit(CartRemoveLoading(currentData));

    final res = await CartRepo.removeFromCart(
      itemId: itemId,
    );

    if (res != null) {
      emit(CartRemoveSuccess(res));
    } else {
      emit(CartRemoveError(currentData));
    }
  }

  // =========================
  // GET CURRENT CART DATA
  // =========================

  Data? _getCurrentCartData() {
    final currentState = state;

    if (currentState is CartSuccess) {
      return currentState.cartData;
    }

    if (currentState is CartUpdateLoading) {
      return currentState.cartData;
    }

    if (currentState is CartUpdateSuccess) {
      return currentState.cartData;
    }

    if (currentState is CartUpdateError) {
      return currentState.cartData;
    }

    if (currentState is CartRemoveLoading) {
      return currentState.cartData;
    }

    if (currentState is CartRemoveSuccess) {
      return currentState.cartData;
    }

    if (currentState is CartRemoveError) {
      return currentState.cartData;
    }

    return null;
  }
}
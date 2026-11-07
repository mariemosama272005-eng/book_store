import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/cart/data/model/cart_model.dart';
import 'package:bookia/feature/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().showCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Failed to update cart'),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is CartRemoveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Failed to remove item'),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is CartRemoveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item removed from cart'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          // =========================
          // INITIAL LOADING
          // =========================
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }

          // =========================
          // CART ERROR
          // =========================
          if (state is CartError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message ?? 'Something went wrong loading your cart.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        context.read<CartCubit>().showCart();
                      },
                      child: const Text(
                        'Try Again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // =========================
          // GET CURRENT DATA & ACTION FLAGS
          // =========================
          Data? cartData;
          int? updatingItemId;
          int? removingItemId;

          if (state is CartSuccess) {
            cartData = state.cartData;
          } else if (state is CartUpdateLoading) {
            cartData = state.cartData;
            updatingItemId = state.updatingItemId;
          } else if (state is CartUpdateSuccess) {
            cartData = state.cartData;
          } else if (state is CartUpdateError) {
            cartData = state.cartData;
          } else if (state is CartRemoveLoading) {
            cartData = state.cartData;
            removingItemId = state.removingItemId;
          } else if (state is CartRemoveSuccess) {
            cartData = state.cartData;
          } else if (state is CartRemoveError) {
            cartData = state.cartData;
          }

          if (cartData == null) {
            return const SizedBox.shrink();
          }

          final cartItemsList = cartData.cartItems ?? [];

          // =========================
          // EMPTY CART
          // =========================
          if (cartItemsList.isEmpty) {
            return RefreshIndicator(
              color: AppColors.mainColor,
              onRefresh: () async {
                await context.read<CartCubit>().showCart();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Add items from Home to see them here',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final isBusy = updatingItemId != null || removingItemId != null;

          // =========================
          // CART LIST & CHECKOUT
          // =========================
          return RefreshIndicator(
            color: AppColors.mainColor,
            onRefresh: () async {
              await context.read<CartCubit>().showCart();
            },
            child: Column(
              children: [
                // =========================
                // ITEMS LIST
                // =========================
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItemsList.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      final item = cartItemsList[index];
                      final quantity = item.itemQuantity ?? 1;
                      final isThisItemUpdating =
                          updatingItemId != null && updatingItemId == item.itemId;
                      final isThisItemRemoving =
                          removingItemId != null && removingItemId == item.itemId;

                      final priceDisplay = (item.itemProductPriceAfterDiscount != null &&
                              item.itemProductPriceAfterDiscount! > 0)
                          ? '\$${item.itemProductPriceAfterDiscount}'
                          : '\$${item.itemProductPrice ?? '0.00'}';

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // =========================
                            // IMAGE
                            // =========================
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.itemProductImage ?? '',
                                width: 70,
                                height: 90,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 70,
                                    height: 90,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 16),

                            // =========================
                            // DETAILS
                            // =========================
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.itemProductName ?? 'Book Title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    priceDisplay,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // =========================
                                  // QUANTITY & DELETE CONTROLS
                                  // =========================
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // QUANTITY CONTROLS
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: isThisItemUpdating
                                            ? const SizedBox(
                                                width: 96,
                                                height: 32,
                                                child: Center(
                                                  child: SizedBox(
                                                    width: 16,
                                                    height: 16,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: AppColors.mainColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  // MINUS BUTTON
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                    ),
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 32,
                                                      minHeight: 32,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    onPressed: isBusy ||
                                                            quantity <= 1 ||
                                                            item.itemId == null
                                                        ? null
                                                        : () {
                                                            context
                                                                .read<CartCubit>()
                                                                .updateCart(
                                                                  itemId: item
                                                                      .itemId!,
                                                                  quantity:
                                                                      quantity - 1,
                                                                );
                                                          },
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 4,
                                                    ),
                                                    child: Text(
                                                      '$quantity',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),

                                                  // PLUS BUTTON
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 16,
                                                    ),
                                                    constraints:
                                                        const BoxConstraints(
                                                      minWidth: 32,
                                                      minHeight: 32,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    onPressed: isBusy ||
                                                            item.itemId == null
                                                        ? null
                                                        : () {
                                                            context
                                                                .read<CartCubit>()
                                                                .updateCart(
                                                                  itemId: item
                                                                      .itemId!,
                                                                  quantity:
                                                                      quantity + 1,
                                                                );
                                                          },
                                                  ),
                                                ],
                                              ),
                                      ),

                                      // DELETE BUTTON
                                      isThisItemRemoving
                                          ? const SizedBox(
                                              width: 32,
                                              height: 32,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : IconButton(
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                              onPressed: isBusy ||
                                                      item.itemId == null
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<CartCubit>()
                                                          .removeFromCart(
                                                            itemId:
                                                                item.itemId!,
                                                          );
                                                    },
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // =========================
                // TOTAL & CHECKOUT BAR
                // =========================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${cartData.total ?? '0.00'}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // Proceed to checkout placeholder
                            },
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
              const SnackBar(
                content: Text(
                  'Failed to update cart',
                ),
              ),
            );
          }

          if (state is CartRemoveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Failed to remove item',
                ),
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
              child: CircularProgressIndicator(),
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
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Something went wrong loading your cart.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().showCart();
                      },
                      child: const Text(
                        'Try Again',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // =========================
          // GET CURRENT DATA
          // =========================

          Data? cartData;

          bool updating = false;
          bool removing = false;

          if (state is CartSuccess) {
            cartData = state.cartData;
          }

          if (state is CartUpdateLoading) {
            cartData = state.cartData;
            updating = true;
          }

          if (state is CartUpdateSuccess) {
            cartData = state.cartData;
          }

          if (state is CartUpdateError) {
            cartData = state.cartData;
          }

          if (state is CartRemoveLoading) {
            cartData = state.cartData;
            removing = true;
          }

          if (state is CartRemoveSuccess) {
            cartData = state.cartData;
          }

          if (state is CartRemoveError) {
            cartData = state.cartData;
          }

          if (cartData == null) {
            return const SizedBox.shrink();
          }

          // =========================
          // CART ITEMS
          // =========================

          final cartItemsList =
              cartData.cartItems ?? [];

          // =========================
          // EMPTY CART
          // =========================

          if (cartItemsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
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
                ],
              ),
            );
          }

          // =========================
          // CART UI
          // =========================

          return Stack(
            children: [
              Column(
                children: [
                  // =========================
                  // ITEMS
                  // =========================

                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: cartItemsList.length,
                      separatorBuilder:
                          (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemBuilder:
                          (context, index) {
                        final item =
                            cartItemsList[index];

                        final quantity =
                            item.itemQuantity ?? 1;

                        return Container(
                          padding:
                              const EdgeInsets.all(12),
                          decoration:
                              BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.1),
                                blurRadius: 6,
                                offset:
                                    const Offset(
                                  0,
                                  3,
                                ),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              // =========================
                              // IMAGE
                              // =========================

                              ClipRRect(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  8,
                                ),
                                child: Image.network(
                                  item.itemProductImage ??
                                      '',
                                  width: 70,
                                  height: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return Container(
                                      width: 70,
                                      height: 90,
                                      color: Colors
                                          .grey
                                          .shade200,
                                      child:
                                          const Icon(
                                        Icons
                                            .image_not_supported,
                                        color:
                                            Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(
                                width: 16,
                              ),

                              // =========================
                              // DETAILS
                              // =========================

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      item.itemProductName ??
                                          'Book Title',
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                    ),

                                    const SizedBox(
                                      height: 6,
                                    ),

                                    Text(
                                      '\$${item.itemProductPriceAfterDiscount ?? item.itemProductPrice ?? '0.00'}',
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.green,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: [
                                        // =========================
                                        // QUANTITY
                                        // =========================

                                        Container(
                                          decoration:
                                              BoxDecoration(
                                            border:
                                                Border.all(
                                              color: Colors
                                                  .grey
                                                  .shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                              6,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              // MINUS
                                              IconButton(
                                                icon:
                                                    const Icon(
                                                  Icons
                                                      .remove,
                                                  size: 16,
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth:
                                                      32,
                                                  minHeight:
                                                      32,
                                                ),
                                                padding:
                                                    EdgeInsets
                                                        .zero,
                                                onPressed:
                                                    updating ||
                                                            removing ||
                                                            quantity <=
                                                                1
                                                        ? null
                                                        : () {
                                                            context
                                                                .read<
                                                                    CartCubit>()
                                                                .updateCart(
                                                                  itemId:
                                                                      item.itemId!,
                                                                  quantity:
                                                                      quantity - 1,
                                                                );
                                                          },
                                              ),

                                              Text(
                                                '$quantity',
                                                style:
                                                    const TextStyle(
                                                  fontWeight:
                                                      FontWeight
                                                          .bold,
                                                ),
                                              ),

                                              // PLUS
                                              IconButton(
                                                icon:
                                                    const Icon(
                                                  Icons
                                                      .add,
                                                  size: 16,
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth:
                                                      32,
                                                  minHeight:
                                                      32,
                                                ),
                                                padding:
                                                    EdgeInsets
                                                        .zero,
                                                onPressed:
                                                    updating ||
                                                            removing
                                                        ? null
                                                        : () {
                                                            context
                                                                .read<
                                                                    CartCubit>()
                                                                .updateCart(
                                                                  itemId:
                                                                      item.itemId!,
                                                                  quantity:
                                                                      quantity + 1,
                                                                );
                                                          },
                                              ),
                                            ],
                                          ),
                                        ),

                                        // =========================
                                        // DELETE
                                        // =========================

                                        IconButton(
                                          icon:
                                              const Icon(
                                            Icons
                                                .delete_outline,
                                            color:
                                                Colors.red,
                                          ),
                                          onPressed:
                                              updating ||
                                                      removing
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<
                                                              CartCubit>()
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
                  // TOTAL
                  // =========================

                  Container(
                    padding:
                        const EdgeInsets.all(20),
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.2),
                          blurRadius: 10,
                          offset:
                              const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style:
                                    TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              Text(
                                '\$${cartData.total ?? '0.00'}',
                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color:
                                      Colors.green,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          // =========================
                          // CHECKOUT
                          // =========================

                          SizedBox(
                            width:
                                double.infinity,
                            height: 50,
                            child:
                                ElevatedButton(
                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    Colors.brown,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    12,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child:
                                  const Text(
                                'Proceed to Checkout',
                                style:
                                    TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  color:
                                      Colors.white,
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

              // =========================
              // LOADING OVERLAY
              // =========================

              if (updating || removing)
                Positioned.fill(
                  child: Container(
                    color: Colors.black
                        .withValues(
                      alpha: 0.05,
                    ),
                    child:
                        const Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
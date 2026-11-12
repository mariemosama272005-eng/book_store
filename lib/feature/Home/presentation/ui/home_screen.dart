import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:bookia/feature/Home/presentation/ui/wedgit/bookItem_wedgit.dart';
import 'package:bookia/feature/Home/presentation/ui/wedgit/home_appBar_wedgit.dart';
import 'package:bookia/feature/Home/presentation/ui/wedgit/slider_wedgit.dart';
import 'package:bookia/feature/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..slider()
        ..getbestsellerBooks(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              const HomeAppBarWedgit(),

              25.verticalSpace,

              BlocListener<HomeCubit, HomeState>(
                listenWhen: (previous, current) =>
                    current is addToCartLoading ||
                    current is addToCartSuccess ||
                    current is addToCartError,
                listener: (context, state) {
                  if (state is addToCartLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      ),
                    );
                  } else if (state is addToCartSuccess) {
                    Navigator.of(context, rootNavigator: true).pop();
                    try {
                      context.read<CartCubit>().showCart();
                    } catch (_) {}
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product added to cart successfully"),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (state is addToCartError) {
                    Navigator.of(context, rootNavigator: true).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message ?? "Failed to add product to cart"),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: const SizedBox.shrink(),
              ),

              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    current is SliderLoading ||
                    current is SliderError ||
                    current is SliderSuccess,
                builder: (context, state) {
                  if (state is SliderLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  }

                  if (state is SliderSuccess) {
                    return CustomSliderWidget(slidersList: state.slider ?? []);
                  }

                  return const Center(child: Text("Error loading sliders"));
                },
              ),

              20.verticalSpace,

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      current is getbestsellerError ||
                      current is getbestsellerSuccess ||
                      current is getbestsellerLoading,
                  builder: (context, state) {
                    if (state is getbestsellerLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return BookitemWedgit(
                              prodcut: Products(
                                name: "test",
                                price: "333",
                                image:
                                    "https://image-processor-storage.s3.us-west-2.amazonaws.com/images/3cf61c1011912a2173ea4dfa260f1108/halo-of-neon-ring-illuminated-in-the-stunning-landscape-of-yosemite.jpg",
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (state is getbestsellerSuccess) {
                      final products = state.products ?? [];

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return BookitemWedgit(prodcut: products[index]);
                        },
                      );
                    }

                    return const Center(
                      child: Text("Error loading bestseller books"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

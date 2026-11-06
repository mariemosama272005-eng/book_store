import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:bookia/feature/Home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookitemWedgit extends StatelessWidget {
  final Products? prodcut;

  const BookitemWedgit({super.key, this.prodcut});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.bookditailsScreen,
          arguments: prodcut?.id,
        );
      },
      child: Container(
        width: 163.w,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                prodcut?.image ?? '',
                width: double.infinity,
                height: 175.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: double.infinity,
                    height: 175.h,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),

            10.verticalSpace,

            Text(
              prodcut?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp),
            ),

            4.verticalSpace,

            Row(
              children: [
                Expanded(
                  child: Text(
                    prodcut?.price ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),

                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    context.read<HomeCubit>().addToCart(prodcut?.id ?? 0);
                  },
                  icon: Icon(Icons.shopping_cart, size: 22.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

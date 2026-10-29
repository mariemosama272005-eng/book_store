import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookitemWedgit extends StatelessWidget {
  final Products ? prodcut;
  const BookitemWedgit({super.key, this.prodcut});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.bookditailsScreen,arguments: prodcut?.id);
      },
      child: Container(
        padding: EdgeInsets.all(20.r),
        width: 163.w,
        height: 281.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
            child: Image.network(prodcut?.image??"",
            width: 140.w,
             height: 175.h,
            fit: BoxFit.cover,
            ),
            ),
            20.verticalSpace,
            Text(prodcut?.name??"",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),
            8.verticalSpace,
            Row(
              children: [
                Expanded(child:Text(prodcut?.price??"")),
                IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
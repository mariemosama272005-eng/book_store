import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBarWedgit extends StatelessWidget {
  const HomeAppBarWedgit({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
             Assets.images.splash.image(
              width: 99.w,
              height: 30.h,
             ),
             InkWell(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.searchScreen);
              }
              ,child: Icon(Icons.search,size: 30.r,)),
        ],
    );
  }
}
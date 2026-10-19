import 'package:bookia/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWedgit extends StatelessWidget {
  const AppbarWedgit({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundc,
      leading: Container(
        width: 41.w,
        height: 41.h,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white
        ),
        child: BackButton(onPressed: (){
Navigator.pop(context);
        }),

      ),
      actions: [
         IconButton(onPressed: (){
                      if(context.locale.languageCode=='ar'){
                        context.setLocale(Locale('en'));
                      }else{
                        context.setLocale(Locale('ar'));
                      }

                    },icon: Icon(Icons.language)),
      ],
    );
  }
}
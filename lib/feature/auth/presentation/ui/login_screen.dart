import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/login_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
            child: Column(
           
          children: [
            AppbarWedgit(),
            Text("welcome".tr(),style: AppTextstyle.font30regular,),
            32.verticalSpace,
            LoginForm(),
          Align(
            alignment: AlignmentGeometry.bottomEnd,
            child: Row(
              children: [
                Text("noAccount".tr(),style:AppTextstyle.subTextstyle,),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.registerScreen);

                  },
                  child: Text("regNow".tr(),style: AppTextstyle.subTextstyle.copyWith(color: AppColors.mainColor),),
                )
              ],
            ),
          )
            
          ],
        ),
      ),
      
      
    );
  }
}
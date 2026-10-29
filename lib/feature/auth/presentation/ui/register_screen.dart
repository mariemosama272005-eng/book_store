import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/register_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
            child: Column(
           
          children: [
            AppbarWedgit(),
            Text("hello".tr(),style: AppTextstyle.font30regular,),
            32.verticalSpace,
            RegisterForm()
            
          ],
        ),
      ),
      
      
    );
  }
}
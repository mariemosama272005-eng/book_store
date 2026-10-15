import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset("assets/images/welcome.png").image),
            ),
            child: Column(
                children: [
                    135.verticalSpace,
                    Image.asset("assets/images/splash.png"),
                    28.verticalSpace,
                    Text("Order Your Book Now!",style:AppTextstyle.subTextstyle),
                    333.verticalSpace,
                    MainbuttonWedgit(title: "Login",onTap: () {
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },),
                    15.verticalSpace,
                    MainbuttonWedgit(title: "Register",bgColor: AppColors.borderColor,textColor:AppColors.drarkColor, 
                     onTap:(){
                       Navigator.pushNamed(context, AppRoutes.registerScreen);

                     
                    },)
                ],
            ),
        ),
    );
  }
}
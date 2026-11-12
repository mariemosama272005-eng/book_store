import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpWidget extends StatelessWidget {
  final VoidCallback onVerify;
  final List<TextEditingController> controllers;

  const OtpWidget({
    super.key,
    required this.onVerify,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarWedgit(),
          20.verticalSpace,

          Text(
            "OTP Verification",
            style: AppTextstyle.font30regular,
          ),
          8.verticalSpace,
          Text(
            "Enter the verification code we just sent on your email address.",
            style: AppTextstyle.subTextstyle,
          ),
          32.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => SizedBox(
                width: 50.w,
                height: 60.h,
                child: TextFormField(
                  controller: controllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  cursorColor: AppColors.mainColor,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                  ),
                  onChanged: (value) {
                    // Auto-advance to next field
                    if (value.isNotEmpty && index < 4) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            ),
          ),

          40.verticalSpace,
          MainbuttonWedgit(
            title: "Verify",
            onTap: onVerify,
          ),
        ],
      ),
    );
  }
}

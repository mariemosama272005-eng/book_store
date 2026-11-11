import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/shared_wedgits/textForm_wedgit.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/core/util/App_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordWidget extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  const ForgetPasswordWidget({
    super.key,
    required this.formState,
    required this.emailController,
    required this.onSubmit,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppbarWedgit(),
            20.verticalSpace,
        
            Text(
              "Forget Password?",
              style: AppTextstyle.font30regular,
            ),
            8.verticalSpace,
            Text(
              "Enter your email or phone number to receive a reset link.",
              style: AppTextstyle.subTextstyle,
            ),
            32.verticalSpace,
            TextformWedgit(
              controller: emailController,
              hintT: "Enter your email",
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Email is required";
                }
                if (!AppValidator.isValidEmail(v)) {
                  return "Please Enter valid Email";
                }
                return null;
              },
            ),
            40.verticalSpace,
            MainbuttonWedgit(
              title: "Send code",
              onTap: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
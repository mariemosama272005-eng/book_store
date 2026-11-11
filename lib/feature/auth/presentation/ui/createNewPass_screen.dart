import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/createNewPassword_widget.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});
  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}
class _CreateNewPasswordScreenState
    extends State<CreateNewPasswordScreen> {
  final formState = GlobalKey<FormState>();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void dispose() {
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void showPasswordChangedAlert(BuildContext context) {
    showDialog(
      context: context,
      
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor:AppColors.backgroundc,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Assets.images.successmark.image(),
                20.verticalSpace,
                Text(
  "Password Changed!",
  style: AppTextstyle.subTextstyle.copyWith(
    fontWeight: FontWeight.bold,
  ),
  textAlign: TextAlign.center,
),
                10.verticalSpace,
                Text(
                  "Your password has been changed successfully.",
                  style: AppTextstyle.subTextstyle,
                  textAlign: TextAlign.center,
                ),
                24.verticalSpace,
                MainbuttonWedgit(
                  title: "Back to Login",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.loginScreen,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: 	Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppbarWedgit(),
                20.verticalSpace,
                CreateNewPasswordWidget(
                  newPassController: newPassController,
                  confirmPassController: confirmPassController,
                  formState: formState,
                  onResetPassword: () {
                    showPasswordChangedAlert(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
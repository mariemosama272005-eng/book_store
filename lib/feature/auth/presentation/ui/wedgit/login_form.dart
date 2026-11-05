
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/shared_wedgits/textForm_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/core/util/App_validator.dart';
import 'package:bookia/feature/auth/presentation/cubit/cubit/authcubit_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formState = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passcontroller = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthcubitCubit, AuthcubitState>(
      listener: (context, state) {
        if (state is loginLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                ),
              );
            },
          );
        } else if (state is LoginSuccessState) {
       DioFactory.init();
        
            Navigator.pop(context);
          

          Navigator.pushNamed(context, AppRoutes.buttomNavbarScreen);
        }
      },
      child: Form(
        key: formState,
        child: Column(
          children: [
            TextformWedgit(
              controller: emailController,
              hintT: "email".tr(),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "emailRe".tr();
                }

                if (!AppValidator.isValidEmail(v)) {
                  return "validEmail".tr();
                }

                return null;
              },
            ),

            15.verticalSpace,

            TextformWedgit(
              controller: passcontroller,
              hintT: "pass".tr(),
              isPass: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "passReq".tr();
                }

                if (!AppValidator.isPasswordValid(v)) {
                  return "validPass".tr();
                }

                return null;
              },
            ),

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.forgetpassScreen,
                  );
                },
                child: Text(
                  "forgetpass".tr(),
                  style: AppTextstyle.hintTextStyle,
                ),
              ),
            ),

            30.verticalSpace,

            MainbuttonWedgit(
              title: "login".tr(),
              onTap: () {
                if (formState.currentState?.validate() ?? false) {
                  context.read<AuthcubitCubit>().login(
                    email: emailController.text.trim(),
                    password: passcontroller.text,
                  );
               
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

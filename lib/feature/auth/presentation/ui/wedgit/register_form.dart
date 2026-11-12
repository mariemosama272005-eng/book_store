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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var formState = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthcubitCubit, AuthcubitState>(
      listener: (context, state) {
        // Loading
        if (state is registerLoadingState) {
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
        }

        // Register Success
        else if (state is RegisterSuccessState) {
          Navigator.pop(context);

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.buttomNavbarScreen,
          );
        }

        // Register Error
        else if (state is RegisterErrorState) {
          Navigator.pop(context);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Register Failed'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Form(
        key: formState,
        child: Column(
          children: [
            TextformWedgit(
              controller: nameController,
              hintT: "name".tr(),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "nameReq".tr();
                }

                return null;
              },
            ),

            15.verticalSpace,

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
              controller: passController,
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

            15.verticalSpace,

            TextformWedgit(
              controller: confirmPassController,
              hintT: "confPass".tr(),
              isPass: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "passReq".tr();
                }

                if (v != passController.text) {
                  return "passNotMatch".tr();
                }

                return null;
              },
            ),

            15.verticalSpace,

            TextformWedgit(
              controller: addressController,
              hintT: "address".tr(),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "addressReq".tr();
                }

                return null;
              },
            ),

            15.verticalSpace,

            TextformWedgit(
              controller: cityController,
              hintT: "city".tr(),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "cityReq".tr();
                }

                return null;
              },
            ),

            30.verticalSpace,

            MainbuttonWedgit(
              title: "register".tr(),
              onTap: () {
                if (formState.currentState?.validate() ?? false) {
                  context.read<AuthcubitCubit>().register(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passController.text,
                        passwordConfirmation:
                            confirmPassController.text,
                        address: addressController.text.trim(),
                        city: cityController.text.trim(),
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
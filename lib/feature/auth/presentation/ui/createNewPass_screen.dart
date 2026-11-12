import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_textStyle.dart';
import 'package:bookia/feature/auth/presentation/cubit/cubit/authcubit_cubit.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/createNewPassword_widget.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final formState = GlobalKey<FormState>();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  /// Email forwarded from OTP screen.
  late final String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    email = (args is String && args.isNotEmpty) ? args : '';
  }

  @override
  void dispose() {
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void _showPasswordChangedAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: AppColors.backgroundc,
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
    return BlocProvider(
      create: (_) => AuthcubitCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocConsumer<AuthcubitCubit, AuthcubitState>(
            listener: (context, state) {
              if (state is ResetPasswordLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                );
              } else if (state is ResetPasswordSuccessState) {
                Navigator.pop(context); // dismiss loading
                _showPasswordChangedAlert(context);
              } else if (state is ResetPasswordErrorState) {
                Navigator.pop(context); // dismiss loading
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
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
                          if (formState.currentState?.validate() ?? false) {
                            context.read<AuthcubitCubit>().resetPassword(
                                  email: email,
                                  password: newPassController.text,
                                  passwordConfirmation:
                                      confirmPassController.text,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

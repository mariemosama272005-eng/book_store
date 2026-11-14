import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/auth/presentation/cubit/cubit/authcubit_cubit.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/forgetPass_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formState = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
              if (state is forgotPasswordLoadingState) {
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
              } else if (state is ForgotPasswordSuccessState) {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  AppRoutes.otpScreen,
                  arguments: emailController.text.trim(),
                );
              } else if (state is ForgotPasswordErrorState) {
                Navigator.pop(context); 
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ForgetPasswordWidget(
                formState: formState,
                emailController: emailController,
                onSubmit: () {
                  if (formState.currentState?.validate() ?? false) {
                    context.read<AuthcubitCubit>().forgotPassword(
                          email: emailController.text.trim(),
                        );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

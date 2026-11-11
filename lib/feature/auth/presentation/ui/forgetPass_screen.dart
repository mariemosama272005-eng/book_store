import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/forgetPass_widget.dart';
import 'package:flutter/material.dart';


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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child:ForgetPasswordWidget(
          formState: formState,
          emailController: emailController,
          onSubmit: () {
            if (formState.currentState?.validate() ?? false) {
              Navigator.pushNamed(context, AppRoutes.otpScreen);
            }
          },
        ),
      ),
    );
  }
}
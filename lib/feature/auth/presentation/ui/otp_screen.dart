import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/otp_widget.dart';
import 'package:flutter/material.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        
        child: OtpWidget(
          onVerify: () {
            Navigator.pushNamed(context, AppRoutes.createNewPassword);
          },
        ),
      ),
    );
  }
}
import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:bookia/feature/auth/presentation/ui/login_screen.dart';
import 'package:bookia/feature/profile/presentation/ui/widget/profileAppBar.dart';
import 'package:flutter/material.dart';

class  ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Profileappbar(),
      ],
    );
  }
}
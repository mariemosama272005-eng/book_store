import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:flutter/material.dart';

class Profileappbar extends StatelessWidget {
  const Profileappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppbarWedgit(
      title: "Profile",
      icon: Icons.logout,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Do you want to logout?"),
            content: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: MainbuttonWedgit(
                      title: "Cancel",
                      bgColor: Colors.transparent,
                      textColor: AppColors.darkgrey,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MainbuttonWedgit(
                      title: "Confirm",
                      bgColor: Colors.red,
                      onTap: () async {
  await LocalHelper.prefs?.remove(
    AppConstans.userToken,
  );

  if (!context.mounted) return;

  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.welcomeScreen ,
    (route) => false,
  );
},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

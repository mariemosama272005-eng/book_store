
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bookia/core/theme/app_colors.dart';

class AppbarWedgit extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final void Function()? onPressed;

  const AppbarWedgit({
    super.key,
    this.onPressed,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundc,

      leading: Container(
        width: 41.w,
        height: 41.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
        ),
        child: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // Don't force nullable title with !
      title: title != null ? Text(title!) : null,

      centerTitle: true,

      actions: [
        if (icon == null)
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == 'ar') {
                context.setLocale(const Locale('en'));
              } else {
                context.setLocale(const Locale('ar'));
              }
            },
            icon: const Icon(Icons.language),
          )
        else
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
          ),
      ],
    );
  }
}

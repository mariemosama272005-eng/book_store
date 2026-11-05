import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/shared_wedgits/appBar_wedgit.dart';
import 'package:bookia/core/shared_wedgits/mainButton_wedgit.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:bookia/feature/auth/presentation/ui/login_screen.dart';
import 'package:bookia/feature/profile/data/models/profile_model.dart';
import 'package:bookia/feature/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/ui/widget/profileAppBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Profileappbar(),

            SizedBox(height: 20.h),

            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProfileSuccess) {
                  final data = state.pdata?.data;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: data?.image != null
                            ? NetworkImage(data!.image!)
                            : null,
                        child: data?.image == null
                            ? Icon(
                                Icons.person,
                                size: 40.r,
                              )
                            : null,
                      ),

                      SizedBox(width: 20.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data?.name ?? "Name",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 8.h),

                            Text(
                              data?.email ?? "Email",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return const Text("Error");
              },
            ),
          ],
        ),
      ),
    );
  }
}